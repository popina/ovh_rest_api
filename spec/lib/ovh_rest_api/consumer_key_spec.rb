require "spec_helper"

describe OvhRestApi::ConsumerKey do
  context "#generate" do
    before do
      @returned_body = '{"validationUrl": "https://eu.api.ovh.com/auth/?credentialToken=iQ1joJE0OmSPlUAoSw1IvAPWDeaD87ZM64HEDvYq77IKIxr4bIu6fU8OtrPQEeRh","consumerKey": "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1","state": "pendingValidation"}'
      stub_request(:post, "https://eu.api.ovh.com/1.0/auth/credential").with(headers: {"X-Ovh-Application" => "7kbG7Bk7S9Nt7ZSV", "Content-type" => "application/json"}).to_return body: @returned_body, status: 200
      @result = OvhRestApi::Base.generate :eu, "7kbG7Bk7S9Nt7ZSV"
    end
    it { expect(@result).to eq(JSON.parse @returned_body) }
  end

  it { expect(OvhRestApi::Base.all_access_rules).to eq(
    {"accessRules" => [
      { "method" => "GET", "path" => "/*" },
      { "method" => "POST", "path" => "/*" },
      { "method" => "PUT", "path" => "/*" },
      { "method" => "DELETE", "path" => "/*" }
    ]}
  )}
end