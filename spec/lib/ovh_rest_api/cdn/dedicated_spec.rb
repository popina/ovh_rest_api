require "spec_helper"

describe OvhRestApi::Cdn::Dedicated do
  let!(:api_instance){ OvhRestApi::Cdn::Dedicated.new :eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1" }
  
  describe "#services" do
    before do
      stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated").to_return status: 200, body: "[\"cdn-23.123.456.78-910\"]", headers: {}
    end
    
    it { expect(api_instance.services).to eq(['cdn-23.123.456.78-910'])}
  end
  
end