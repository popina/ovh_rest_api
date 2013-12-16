module OvhRestApi
  class << self
    attr_accessor :configuration, :base
  end
  
  class Configuration
    attr_accessor :country, :api_key, :api_secret, :consumer_key
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration if block_given?
    OvhRestApi.base = OvhRestApi::Base.new configuration.country, configuration.api_key, configuration.api_secret, configuration.consumer_key
  end
end

require "digest/sha1"
require "uri"
require "net/http"
require "net/https"
require "json"
require "ovh_rest_api/errors"
require "ovh_rest_api/version"
require "ovh_rest_api/cdn/dedicated"
require "ovh_rest_api/consumer_key"
require "ovh_rest_api/base"
