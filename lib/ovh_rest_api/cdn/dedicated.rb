module OvhRestApi
  module Cdn
    class Dedicated < OvhRestApi::Base
      def services
        get "/cdn/dedicated"
      end

      def service service_name
        get "/cdn/dedicated/#{service_name}"
      end
    end
  end
end