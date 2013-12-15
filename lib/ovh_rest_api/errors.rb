module OvhRestApi
  class ForbiddenCountryException < Exception
    def initialize
      super "only EU or CA are vailable for country code"
    end
  end
end