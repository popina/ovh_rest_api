require "spec_helper"

describe OvhRestApi::Base do
  it { expect(OvhRestApi::Base.api_uri :eu).to eq("https://eu.api.ovh.com/1.0") }
  it { expect { OvhRestApi::Base.api_uri :fr }.to raise_exception(OvhRestApi::ForbiddenCountryException) }
  
  context "when country, api key, api secret and consumer key are given for initialization" do
    before do
      @instance = OvhRestApi::Base.new(:fr, "api_key098765432", "api_secret1234567890", "consumer_key983458765")
    end
    it { expect(@instance.country).to eq(:fr) }
    it { expect(@instance.api_key).to eq("api_key098765432") }
    it { expect(@instance.api_secret).to eq("api_secret1234567890") }
    it { expect(@instance.consumer_key).to eq("consumer_key983458765") }
  end
  
  describe "#request_signature" do
    it { expect(OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1").send :request_signature, "get", "https://eu.api.ovh.com/1.0/domains/", "", 1366560945).to eq("$1$d3705e8afb27a0d2970a322b96550abfc67bb798") }
  end
end