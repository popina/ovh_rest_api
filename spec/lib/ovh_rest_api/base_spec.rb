require "spec_helper"

describe OvhRestApi::Base do
  it { expect(OvhRestApi::Base.api_uri :eu).to eq("https://eu.api.ovh.com/1.0") }
end