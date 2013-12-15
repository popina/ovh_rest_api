# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ovh_rest_api/version'

Gem::Specification.new do |spec|
  spec.name          = "ovh_rest_api"
  spec.version       = OvhRestApi::VERSION
  spec.authors       = ["charlie"]
  spec.email         = ["charlie.eissen@gmail.com"]
  spec.description   = "This is a gem to interact with OVH RESFTULL API 1.0"
  spec.summary       = "This is a gem to interact with OVH RESFTULL API 1.0"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
