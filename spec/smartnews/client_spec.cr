require "./spec_helper"

describe Smartnews::Client do
  describe "#request" do
    it "builds request object" do
      client = Smartnews::Client.new
      client.request.to_s.should eq("https://ads.smartnews.com/api")
    end

    it "respects api" do
      client = Smartnews::Client.new(api: "/api/v1.0")
      client.request.to_s.should eq("https://ads.smartnews.com/api/v1.0")

      client = Smartnews::Client.new
      client.api = Smartnews::Api::Get.new("/api/v1.0/accounts/1000000/insights", data: {"level" => "creative"})
      client.request.to_s.should eq("https://ads.smartnews.com/api/v1.0/accounts/1000000/insights?level=creative")

      client = Smartnews::Client.new
      client.api = "/api/v1.0/accounts/1000000/insights -d level=creative"
      client.request.to_s.should eq("https://ads.smartnews.com/api/v1.0/accounts/1000000/insights?level=creative")

      client = Smartnews::Client.new
      client.api = Smartnews::Api::Get.parse("/api/v1.0/accounts/1000000/insights -d level=creative")
      client.request.to_s.should eq("https://ads.smartnews.com/api/v1.0/accounts/1000000/insights?level=creative")
    end

    it "respects host" do
      client = Smartnews::Client.new(api: "/api")
      client.host = "http://localhost:8080"
      client.request.to_s.should eq("http://localhost:8080/api")
    end
  end

  describe "#get" do
    context "('/foo -d a=1 -d b=2')" do
      it "accepts '-d' as data" do
        client = Smartnews::Client.new(auth: "xxx")
        client.dryrun!

        expect_raises(Smartnews::Dryrun, "curl -s -G -H 'X-Auth-Api: xxx' -d 'a=1' -d 'b=2' https://ads.smartnews.com/foo") do
          client.get("/foo -d a=1 -d b=2")
        end
      end
    end

    context "('/foo -d a=1 -d b=2', {a=>x})" do
      it "overwrites data by parameters" do
        client = Smartnews::Client.new(auth: "xxx")
        client.dryrun!

        expect_raises(Smartnews::Dryrun, "curl -s -G -H 'X-Auth-Api: xxx' -d 'a=x' -d 'b=2' https://ads.smartnews.com/foo") do
          client.get("/foo -d a=1 -d b=2", {"a" => "x"})
        end
      end
    end
  end
  
  describe "#execute" do
    it "raises when auth is not set or empty" do
      client = Smartnews::Client.new(api: "/me")
      expect_raises(Smartnews::Auth::NotAuthorizedError) do
        client.execute
      end

      client.auth = ""
      expect_raises(Smartnews::Auth::NotAuthorizedError) do
        client.execute
      end
    end

    it "raises Dryrun when the strategy is dryrun" do
      client = Smartnews::Client.new(api: "/me")
      client.auth = "xxx"
      client.dryrun!

      expect_raises(Smartnews::Dryrun, "curl -s -G -H 'X-Auth-Api: xxx' https://ads.smartnews.com/me") do
        client.execute
      end
    end

    context "(http connection error)" do
      it "raises with connection info" do
        client = Smartnews::Client.new(api: "/me", auth: "xxx")
        client.host = "http://localhost:4"

        expect_raises(Exception, "Failed to connect localhost port 4") do
          client.execute
        end
      end
    end
  end
end
