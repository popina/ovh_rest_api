module OvhRestApi
  module Cdn
    module Dedicated
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

      def create_domain service_name, domain_name
        post "/cdn/dedicated/#{service_name}/domains", {domain: domain_name}
      end

      def delete_domain service_name, domain_name
        delete "/cdn/dedicated/#{service_name}/domains/#{domain_name}"
      end

    end
  end
end