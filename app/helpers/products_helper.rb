module ProductsHelper

    class AmazonProduct
        attr_accessor :asin
        attr_accessor :title
        attr_accessor :image
        attr_accessor :price
        attr_accessor :url
		attr_accessor :feature

		def initialize
			@feature = ""
		end
    end

    class AmazonProductQuery
        require 'time'
        require 'uri'
        require 'openssl'
        require 'base64'
        require 'open-uri'
        require 'nokogiri'

        ENDPOINT = "webservices.amazon.com"
        REQUEST_URI = "/onca/xml"

        def initialize(associate_tag)
            @params = {
                "Service" => "AWSECommerceService",
                "Operation" => "ItemSearch",
                "SearchIndex" => "All",
                "ResponseGroup" => "Images,ItemAttributes,Offers",
                "AssociateTag" => associate_tag,
                "Timestamp" => Time.now.gmtime.iso8601
            }
        end

        def set_credential(id, key)
            @params["AWSAccessKeyId"] = id
            @secret_key = key
        end

        def generate_url
            canonical_query_string = @params.sort.collect do |key, value|
                [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
            end.join('&')
            string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"
            signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @secret_key, string_to_sign)).strip()

            # Generate the signed URL
            request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
        end

        def search(keywords)
            items = []
            @params["Keywords"] = keywords
	    for page in 1..5 do
                @params["ItemPage"] = page
                result = Nokogiri::XML(open(generate_url))
                result.css("Item").each do |i|
                    item = AmazonProduct.new
		    next if i.at_css("ASIN") == nil
                    item.asin = i.at_css("ASIN").text
		    next if i.at_css("ItemAttributes/Title") == nil
                    item.title = i.at_css("ItemAttributes/Title").text
		    next if i.at_css("DetailPageURL") == nil
                    item.url = i.at_css("DetailPageURL").text
		    next if i.at_css("SmallImage/URL") == nil
		    next if i.at_css("MediumImage/URL") == nil
		    next if i.at_css("LargeImage/URL") == nil
                    item.image = [i.at_css("SmallImage/URL").text, i.at_css("MediumImage/URL").text, i.at_css("LargeImage/URL").text]
		    next if i.at_css("LowestNewPrice/FormattedPrice") == nil
		    next if i.at_css("LowestNewPrice/FormattedPrice").text[0] != '$'
                    item.price = i.at_css("LowestNewPrice/FormattedPrice").text
					features = []
					features = i.css("ItemAttributes/Feature") unless i.css("ItemAttributes/Feature") == nil
					features.each do |f|
						item.feature << f.text + "\n"
					end
                    items << item
                end
            end
            items
		end
    end
end

