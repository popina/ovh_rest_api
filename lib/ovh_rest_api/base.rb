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
  end
end
