module OvhRestApi
  class ForbiddenCountryException < Exception
    def initialize
      super "only EU or CA are vailable for country code"
    end
  end
  
  class RequestException < Exception
    attr_reader :code, :description
    def initialize code, message
      @code = code
      @description = message
      super "request error : code #{code}, message : #{message}"
    end
  end
end