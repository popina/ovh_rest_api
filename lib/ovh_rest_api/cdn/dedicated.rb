module OvhRestApi
  module Cdn
    class Dedicated < OvhRestApi::Base
      def services
        get "/cdn/dedicated"
      end

      def service service_name
        get "/cdn/dedicated/#{service_name}"
      end

      def domains service_name
        get "/cdn/dedicated/#{service_name}/domains"
      end

      def domain service_name, domain_name
        get "/cdn/dedicated/#{service_name}/domains/#{domain_name}"
      end
    end
  end
end