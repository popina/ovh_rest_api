module OvhRestApi
  module Cdn
    class Dedicated < OvhRestApi::Base
      def services
        get "/cdn/dedicated"
      end
    end
  end
end