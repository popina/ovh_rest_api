module OvhRestApi
  class OvhRestApi::ConsumerKey < OvhRestApi::Base
    
    def self.generate country, api_key, access_rules = nil
      access_rules ||= all_access_rules
      uri = URI.parse "#{api_uri(country)}/auth/credential"
      request = Net::HTTP::Post.new uri.path, {"X-Ovh-Application" => api_key, "Content-type" => "application/json"}
      request.body = access_rules.to_json
      http = Net::HTTP.new uri.host, uri.port
      http.use_ssl = true
      response = http.request request
      JSON.parse response.body
    end
    
    def self.all_access_rules
      {
        "accessRules" => [
          { "method" => "GET", "path" => "/*" },
          { "method" => "POST", "path" => "/*" },
          { "method" => "PUT", "path" => "/*" },
          { "method" => "DELETE", "path" => "/*" }
        ]
      }
    end

  end
end