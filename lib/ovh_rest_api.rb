module OvhRestApi
end

require "digest/sha1"
require "uri"
require "net/http"
require "net/https"
require "json"
require "ovh_rest_api/errors"
require "ovh_rest_api/version"
require "ovh_rest_api/base"
require "ovh_rest_api/consumer_key"
require "ovh_rest_api/cdn/dedicated"