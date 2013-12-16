# OvhRestApi

This is a gem to interact with OVH RESFTULL API 1.0
https://api.ovh.com

## Installation

Add this line to your application's Gemfile:

    gem 'ovh_rest_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ovh_rest_api

## Usage

    OvhRestApi.configure do |config|
      config.country = :eu or :ca
      config.api_key = "your_api_key"
      config.api_secret = "your_api_secret_key"
      config.consumer_key = "your_consumer_key"
    end

then you can access a configured instance of OvhRestApi::Base directly onto OvhRestApi module: 

    OvhRestApi.base

and use methods:

    my_services = OvhRestApi.base.services
    domains_on_service = OvhRestApi.base.domains my_services.first
    ...

## Contributing

1. Fork it
2. run "rake" to test
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
