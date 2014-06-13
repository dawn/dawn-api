require_relative '../api_spec_helper.rb'

describe Dawn::App do
  context "::all" do
    it "should retrieve all user Apps" do
      Dawn::App.all
    end
  end

  context "::create" do
    it "should create 1 App given a name" do
      Dawn::App.create(name: "cookie-crushers")
    end
    it "should fail to create App given improper name" do
      expect { Dawn::App.create(name: "ThaTunaCorps") }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  context "::find" do
    it "should retrieve 1 app by id" do
      app = Dawn::App.all.first
      Dawn::App.find(id: app.id)
    end
    it "should retrieve 1 app by name" do
      Dawn::App.find(name: "cookie-crushers")
    end
  end

  let(:app) { Dawn::App.find(name: "cookie-crushers") }

  context "#restart" do
    it "should restart the the app" do
      app.restart
    end
  end

  context "#logs" do
    it "should retrieve logs url for app" do
      app.logs
    end
  end

  context "#scale" do
    it "should scale app" do
      app.scale web: 2
    end
    it "should have updated formation" do
      app.formation["web"].should eq("2")
    end
  end

  context "#gears" do
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

  context "#drains" do
    it "should have drains" do
      expect(app.drains).to be_an_instance_of(Dawn::App::Drains)
    end
    it "should retrieve drains" do
      app.drains.all
    end
  end

  context "#domains" do
    it "should have domains" do
      expect(app.domains).to be_an_instance_of(Dawn::App::Domains)
    end
    it "should retrieve domains" do
      app.domains.all
    end
  end

  context "#releases" do
    it "should have releases" do
      expect(app.releases).to be_an_instance_of(Dawn::App::Releases)
    end
    it "should retrieve releases" do
      app.releases.all
    end
  end

  context "#update" do
    it "should update 1 app" do
      app = Dawn::App.find(name: "cookie-crushers")
      app.update(name: "bread-crushers")
    end
  end

  context "#destroy" do
    it "should destroy 1 app" do
      app = Dawn::App.find(name: "bread-crushers")
      app.destroy
    end
  end
end
