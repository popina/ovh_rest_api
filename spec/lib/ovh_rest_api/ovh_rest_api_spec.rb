require "spec_helper"

describe OvhRestApi::Base do
  describe "allows configuration" do
    before do
      OvhRestApi.configure do |config|
        config.country = :eu
        config.api_key = "api_key3333333"
        config.api_secret = "api_secret222222"
        config.consumer_key = "consumer_key11111111"
      end
    end
    
    it { expect(OvhRestApi.base.country).to eq(:eu) }
    it { expect(OvhRestApi.base.api_key).to eq("api_key3333333") }
    it { expect(OvhRestApi.base.api_secret).to eq("api_secret222222") }
    it { expect(OvhRestApi.base.consumer_key).to eq("consumer_key11111111") }
  end
end