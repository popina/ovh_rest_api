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
    it { expect(OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", 
      "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
      .send :request_signature, "get", "https://eu.api.ovh.com/1.0/domains/", "", 1366560945)
      .to eq("$1$d3705e8afb27a0d2970a322b96550abfc67bb798") }
  end
  
  describe "#request_signature" do
    before do
      @timestamp = Time.new 2013, 12, 15, 19, 8, 00, "+02:00"
      Time.stub(:now).and_return @timestamp
    end
    it { expect(OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
      .send :request_headers, "get", "https://eu.api.ovh.com/1.0/domains/", "")
      .to eq(
        {
          "X-Ovh-Application" => "7kbG7Bk7S9Nt7ZSV",
          "X-Ovh-Consumer" => "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1",
          "X-Ovh-Timestamp" => @timestamp.to_i.to_s,
          "X-Ovh-Signature" => "$1$def8d1895aeedb730d595ea48120ffb43f67310c",
          "Content-type" => "application/json"
        }
    ) }
  end
  
  context "when requesting get url" do
    before do
      @timestamp = Time.new 2013, 12, 15, 19, 8, 00, "+02:00"
      Time.stub(:now).and_return @timestamp
    end

    context "without http error" do
      before do
        stub_request(:get, "https://eu.api.ovh.com/1.0https://eu.api.ovh.com/1.0/domains/")
              .with(headers: {
                'Accept'=>'*/*', 
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Content-Type'=>'application/json', 
                'User-Agent'=>'Ruby', 
                'X-Ovh-Application'=>'7kbG7Bk7S9Nt7ZSV', 
                'X-Ovh-Consumer'=>'MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1', 
                'X-Ovh-Signature'=>'$1$94a2cce12ac7401b2ec29f90e011d3b19a87ea6a', 
                'X-Ovh-Timestamp'=>'1387127280'})
            .to_return(status: 200, body: '["ovh.com","ovh.net"]', headers: {})
      end
      
      it { expect(OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
          .get("https://eu.api.ovh.com/1.0/domains/")).to eq(["ovh.com","ovh.net"])
        }
    end
    
    context "with http error" do
      before do
        stub_request(:get, "https://eu.api.ovh.com/1.0https://eu.api.ovh.com/1.0/domains/")
              .with(headers: {
                'Content-Type'=>'application/json', 
                'X-Ovh-Application'=>'7kbG7Bk7S9Nt7ZSV', 
                'X-Ovh-Consumer'=>'MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1', 
                'X-Ovh-Signature'=>'$1$94a2cce12ac7401b2ec29f90e011d3b19a87ea6a', 
                'X-Ovh-Timestamp'=>'1387127280'})
            .to_return(status: 409, body: "{\"message\":\"CDN already configured for this domain\"}", headers: {"content-type" => "application/json; charset=utf-8"})
      end
      it { expect { OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
          .get("https://eu.api.ovh.com/1.0/domains/") }.to raise_error(OvhRestApi::RequestException){|e| expect(e.code).to eq 409 }
        }
    end
  end
end