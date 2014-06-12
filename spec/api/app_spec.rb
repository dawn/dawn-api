require_relative '../api_spec_helper.rb'

describe Dawn::App do
  describe "::all" do
    it "should retrieve all user Apps" do
      Dawn::App.all
    end
  end

  describe "::create" do
    it "should create 1 App given a name" do
      Dawn::App.create(name: "cookie-crushers")
    end
    it "should fail to create App given improper name" do
      expect { Dawn::App.create(name: "ThaTunaCorps") }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  describe "::find" do
    it "should retrieve 1 app by id" do
      app = Dawn::App.all.first
      Dawn::App.find(id: app.id)
    end
    it "should retrieve 1 app by name" do
      Dawn::App.find(name: "cookie-crushers")
    end
  end

  describe "#restart" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should restart the the app" do
      app.restart
    end
  end

  describe "#logs" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should retrieve logs url for app" do
      app.logs
    end
  end

  describe "#scale" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should scale app" do
      app.scale web: 2
    end
    it "should have updated formation" do
      app.formation["web"].should eq("2")
    end
  end

  describe "#gears" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should have gears" do
      expect(app.gears).to be_an_instance_of(Dawn::App::Gears)
    end
    it "should retrieve gears" do
      app.gears.all
    end
    it "should restart gears" do
      app.gears.restart
    end
  end

  describe "#drains" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should have drains" do
      expect(app.drains).to be_an_instance_of(Dawn::App::Drains)
    end
    it "should retrieve drains" do
      app.drains.all
    end
  end

  describe "#domains" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should have domains" do
      expect(app.domains).to be_an_instance_of(Dawn::App::Domains)
    end
    it "should retrieve domains" do
      app.domains.all
    end
  end

  describe "#releases" do
    let(:app) { Dawn::App.find(name: "cookie-crushers") }
    it "should have releases" do
      expect(app.releases).to be_an_instance_of(Dawn::App::Releases)
    end
    it "should retrieve releases" do
      app.releases.all
    end
    it "should retrieve gears" do
      app.gears.all
    end
  end

  describe "#update" do
    it "should update 1 app" do
      app = Dawn::App.find(name: "cookie-crushers")
      app.update(name: "bread-crushers")
    end
  end

  describe "#destroy" do
    it "should destroy 1 app" do
      app = Dawn::App.find(name: "bread-crushers")
      app.destroy
    end
  end
end
