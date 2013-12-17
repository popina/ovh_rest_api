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
          context "without query params" do
            before do
              stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated").
                       with(:headers => {'Content-Type'=>'application/json', 'X-Ovh-Application'=>'7kbG7Bk7S9Nt7ZSV', 'X-Ovh-Consumer'=>'MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1', 'X-Ovh-Signature'=>'$1$83f3018b34def983122ef14417e63f9cb5464bc3', 'X-Ovh-Timestamp'=>'1387127280'}).
                       to_return(:status => 200, :body => '["ovh.com","ovh.net"]', :headers => {})
              end

              it { expect(OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
                .get("/cdn/dedicated")).to eq(["ovh.com","ovh.net"])
              }
            end

            
          end

          context "with http error" do
            before do
              stub_request(:get, "https://eu.api.ovh.com/1.0/cdn/dedicated/cdn-46.105.198.55-656/domains/assets.howl.it/statistics?period=month&type=cdn&value=bandwidth").
                       with(:headers => {'Content-Type'=>'application/json', 'X-Ovh-Application'=>'7kbG7Bk7S9Nt7ZSV', 'X-Ovh-Consumer'=>'MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1', 'X-Ovh-Signature'=>'$1$e102895145dd0b42c28bdbae5eb40e843cfc1770', 'X-Ovh-Timestamp'=>'1387127280'}).
                       to_return(:status => 409, :body => "{\"message\":\"CDN already configured for this domain\"}", :headers => {})
              end
              it { expect { OvhRestApi::Base.new(:eu, "7kbG7Bk7S9Nt7ZSV", "EXEgWIz07P0HYwtQDs7cNIqCiQaWSuHF", "MtSwSrPpNjqfVSmJhLbPyr2i45lSwPU1")
                .get("/cdn/dedicated/cdn-46.105.198.55-656/domains/assets.howl.it/statistics?period=month&type=cdn&value=bandwidth") }.to raise_error(OvhRestApi::RequestException){|e| expect(e.code).to eq 409 }
              }
            end
          end
        end