module ProductHelper

    class AmazonProduct
        attr_accessor :asin
        attr_accessor :title
        attr_accessor :image
        attr_accessor :price
        attr_accessor :url
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
            @params["Keywords"] = keywords
            result = Nokogiri::XML(open(generate_url))
            items = []
            result.css("Item").each do |i|
                puts i
                item = AmazonProduct.new
                item.asin = i.css("ASIN").text
                item.title = i.at_css("ItemAttributes/Title").text
                item.url = i.at_css("DetailPageURL").text
                item.image = [i.at_css("SmallImage/URL").text, i.at_css("MediumImage/URL").text, i.at_css("LargeImage/URL").text]
                if i.at_css("LowestNewPrice/FormattedPrice") == nil
                    item.price = "N/A"
                else
                    item.price = i.at_css("LowestNewPrice/FormattedPrice").text
                end
                items << item
            end
            items
        end
    end
end

