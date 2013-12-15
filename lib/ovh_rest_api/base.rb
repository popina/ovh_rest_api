module OvhRestApi
  class Base
    attr_accessor :country, :api_key, :api_secret, :consumer_key
    
    def initialize country, api_key, api_secret, consumer_key
      @country, @api_key, @api_secret, @consumer_key = country, api_key, api_secret, consumer_key
    end
    
    def self.api_uri country_code
      raise ForbiddenCountryException unless [:ca, :eu].include? country_code
      "https://#{country_code}.api.ovh.com/1.0"
    end
    
    private

      def request_signature method, url, body, timestamp
        "$1$" + Digest::SHA1.hexdigest("#{@api_secret}+#{@consumer_key}+#{method.upcase}+#{url}+#{body}+#{timestamp}")
      end
      
      def request_headers method, url, body
        timestamp = Time.now.to_i.to_s
        signature = request_signature method, url, body, timestamp

        {
          "X-Ovh-Application" => @api_key,
          "X-Ovh-Consumer" => @consumer_key,
          "X-Ovh-Timestamp" => timestamp,
          "X-Ovh-Signature" => signature,
          "Content-type" => "application/json"
        }
      end
  end
end
