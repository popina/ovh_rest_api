module OvhRestApi
  module Hosting
    module Web
      def hostings
        get "/hosting/web"
      end

      def hosting service_name
        get "/hosting/web/#{service_name}"
      end

      def subdomains service_name
        get "/hosting/web/#{service_name}/attachedDomain"
      end

      def subdomain service_name, domain_name
        get "/hosting/web/#{service_name}/attachedDomain/#{domain_name}"
      end

      def create_subdomain service_name, path
        post "/hosting/web/#{service_name}/attachedDomain", { domain: path+"."+service_name, path: path, firewall: "none", ssl: false }
      end

      def delete_subdomain service_name, domain_name
        delete "/hosting/web/#{service_name}/attachedDomain/#{domain_name}"
      end
    end
  end
end