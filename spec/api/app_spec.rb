require_relative '../api_spec_helper.rb'

describe Dawn::App do
  context ".all" do
    it "should retrieve all user Apps" do
      Dawn::App.all
    end

    it "should only have an array of Apps" do
      Dawn::App.all.all? { |o| expect(o).to be_an_instance_of(Dawn::App) }
    end
  end

  context ".create" do
    it "should raise an IndexError if app key is missing" do
      expect { Dawn::App.create(blurp: { name: "cookie-crushers" }) }.to raise_error(IndexError)
    end

    it "should create a new app, given a name" do
      Dawn::App.create(app: { name: "cookie-crushers" })
    end

    it "should raise an Excon::Errors::UnprocessableEntity when an invalid name is given" do
      expect { Dawn::App.create(app: { name: "ThaTunaCorps" }) }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  context ".find" do
    it "should retrieve 1 app by id" do
      app = Dawn::App.all.first
      Dawn::App.find(id: app.id)
    end

    it "should retrieve 1 app by name" do
      Dawn::App.find(name: "cookie-crushers")
    end

    it "should fail to find a non existant app" do
      expect { Dawn::App.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context ".update" do
    it "should raise an IndexError if app key is missing" do
      expect { Dawn::App.update(name: "cookie-crushers", blurp: { name: "cookie-crushers2" }) }.to raise_error(IndexError)
    end

    it "should fail to update non-existant app" do
      expect { Dawn::App.update(name: "some-app", app: { name: "some-app-thing" }) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context ".destroy" do
    it "should fail to destroy non-existant app" do
      expect { Dawn::App.destroy(name: "some-app") }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context ".logs" do
    it "should fail to retrieve logs uri for a non existant app" do
      expect { Dawn::App.logs(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  let(:app) { Dawn::App.find(name: "cookie-crushers") }

  context "#restart" do
    it "should restart the the app" do
      app.restart
    end

    it "should fail to restart a non existant app" do
      expect { Dawn::App.restart(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context "#logs" do
    it "should retrieve logs url for app" do
      app.logs
    end
  end

  context "#scale" do
    it "should raise an IndexError if app key is missing" do
      expect { app.scale blurp: { formation: { web: 2 } } }.to raise_error(IndexError)
    end

    it "should scale app" do
      app.scale app: { formation: { web: 2 } }
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
      app.update(app: { name: "bread-crushers" })
    end
  end

  context "#destroy" do
    it "should destroy 1 app" do
      app = Dawn::App.find(name: "bread-crushers")
      app.destroy(name: "bread-crushers")
    end
  end
end
