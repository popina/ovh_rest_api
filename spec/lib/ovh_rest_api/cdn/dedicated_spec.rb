require "spec_helper"

describe OvhRestApi::Cdn::Dedicated do
  let!(:api_instance){ OvhRestApi::Cdn::Dedicated.new :eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1" }
  
  describe "#services" do
    before do
      stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated").to_return status: 200, body: "[\"cdn-23.123.456.78-910\"]"
    end
    
    it { expect(api_instance.services).to eq(['cdn-23.123.456.78-910'])}
  end
  
  describe "#service" do
    before do
      stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated/cdn-23.123.456.78-910")
      .to_return status: 200, body: "{\"quota\":58059979796005,\"backendUse\":2,\"lastQuotaOrder\":\"2013-08-16T09:56:04+02:00\",\"offer\":\"classic.2013v1\",\"anycast\":\"11.123.456.78\",\"backendLimit\":10,\"service\":\"cdn-11.123.456.78-656\",\"cacheRuleLimitPerDomain\":10}"
    end
    
    it { expect(api_instance.service "cdn-23.123.456.78-910")
          .to eq({
            "quota"=>58059979796005,
            "backendUse"=>2, 
            "lastQuotaOrder"=>"2013-08-16T09:56:04+02:00", 
            "offer"=>"classic.2013v1", 
            "anycast"=>"11.123.456.78", 
            "backendLimit"=>10, 
            "service"=>"cdn-11.123.456.78-656", 
            "cacheRuleLimitPerDomain"=>10
            } )}
  end
  
  describe "#domains" do
    before do
      stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated/cdn-23.123.456.78-910/domains")
      .to_return status: 200, body: "[\"host.domain1.com\",\"host2.domain1.com\"]"
    end
    
    it { expect(api_instance.domains "cdn-23.123.456.78-910").to eq(['host.domain1.com', 'host2.domain1.com'])}
  end
  
  describe "#domain" do
    before do
      stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated/cdn-23.123.456.78-910/domains/host.domain1.com")
      .to_return status: 200, body: "{\"cacheRuleUse\":3,\"domain\":\"host.domain1.com\",\"status\":\"off\",\"type\":\"plain\",\"cname\":\"assets.host.it.web.cdn.anycast.me\"}"
    end
    
    it { expect(api_instance.domain "cdn-23.123.456.78-910", "host.domain1.com")
          .to eq(
            {"cacheRuleUse"=>3, "domain"=>"host.domain1.com", "status"=>"off", "type"=>"plain", "cname"=>"assets.host.it.web.cdn.anycast.me"}
          )
      }
  end
  
  describe "#create_domain" do
    before do
      stub_request(:post,"https://eu.api.ovh.com/1.0/cdn/dedicated/cdn-23.123.456.78-910/domains").with({domain: "host.newdomain.com"})
      .to_return status: 200, body: "{\"cacheRuleUse\":0,\"domain\":\"host.newdomain.com\",\"status\":\"on\",\"type\":\"plain\",\"cname\":\"host.newdomain.com.web.cdn.anycast.me\"}"
    end
    
    it { expect(api_instance.create_domain "cdn-23.123.456.78-910", "host.newdomain.com")
          .to eq(
            {"cacheRuleUse"=>0, "domain"=>"host.newdomain.com", "status"=>"on", "type"=>"plain", "cname"=>"host.newdomain.com.web.cdn.anycast.me"}
          )
      }
  end
  
end