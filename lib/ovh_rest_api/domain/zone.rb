module OvhRestApi
  module Domain
    module Zone
      def zones
        get "/domain/zone"
      end

      def zone zone_name
        get "/domain/zone/#{zone_name}"
      end

      def records zone_name
        get "/domain/zone/#{zone_name}/record?fieldType=A"
      end

      def record zone_name, subdomain
        get "/domain/zone/#{zone_name}/record?fieldType=A&subDomain=#{subdomain}"
      end

      def create_record zone_name, subdomain
        post "/domain/zone/#{zone_name}/record", {
          fieldType: "A",
          subDomain: subdomain,
          target: "213.186.33.4",
          ttl: 0
        }
        post "/domain/zone/#{zone_name}/refresh"
      end

      def delete_record zone_name, subdomain
        delete "/domain/zone/#{zone_name}/record/#{subdomain}"
      end
    end
  end
end