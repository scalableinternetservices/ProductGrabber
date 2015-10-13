module ApplicationHelper

    class AWSUrlGenerator
        require 'time'
        require 'uri'
        require 'openssl'
        require 'base64'

        ENDPOINT = "webservices.amazon.com"
        REQUEST_URI = "/onca/xml"
    
        def initialize
            @params = {
                "Service" => "AWSECommerceService",
                "Operation" => "ItemSearch",
                "SearchIndex" => "All",
                "ResponseGroup" => "Images,Offers"
            }
        end

        def set_access_key_id(id)
            @params["AWSAccessKeyId"] = id
        end

        def set_secret_key(key)
            @secret_key = key
        end

        def set_associate_tag(tag)
            @params["AssociateTag"] = tag
        end

        def set_keywords(keywords)
            @params["Keywords"] = keywords
        end
    
        def set_timestamp
            @params["Timestamp"] = Time.now.gmtime.iso8601 if !@params.key?("Timestamp")
        end

        def generate
            canonical_query_string = @params.sort.collect do |key, value|
                [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
            end.join('&')
            string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"
            signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @secret_key, string_to_sign)).strip()

            # Generate the signed URL
            request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
        end

    end
end

