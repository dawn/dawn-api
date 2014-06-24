require 'api_spec_helper'

describe Dawn::App, :vcr do
  subject { Dawn::App }

  let(:app_name1) { "cookie-crushers" }
  let(:app_name2) { "cookie-crushers2" }
  let(:app_name3) { "some-app" }
  let(:app_name4) { "some-app-thing" }
  let(:invalid_app_name) { "ThaTunaCorps" }

  let(:app) { Dawn::App.find(name: app_name1) }

  it { should be_a Class }

  describe ".all" do
    it "should retrieve all user apps" do
      subject.all
    end

    it "should only have an array of apps" do
      subject.all.all? { |o| expect(o).to be_an_instance_of(Dawn::App) }
    end
  end

  describe ".create" do
    it "should raise an IndexError if app key is missing" do
      expect { subject.create(blurp: { name: app_name1 }) }.to raise_error(IndexError)
    end

    it "should create a new app, given a name" do
      subject.create(app: { name: app_name1 })
    end

    it "should raise an Excon::Errors::UnprocessableEntity when an invalid name is given" do
      expect { subject.create(app: { name: invalid_app_name }) }.to raise_error(Excon::Errors::UnprocessableEntity)
    end
  end

  describe ".find" do
    it "should retrieve 1 app by id" do
      app = subject.all.first
      subject.find(id: app.id)
    end

    it "should retrieve 1 app by name" do
      subject.find(name: app_name1)
    end

    it "should fail to find a non existant app" do
      expect { subject.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe ".update" do
    it "should raise an IndexError if app key is missing" do
      expect { subject.update(name: app_name1, blurp: { name: app_name2 }) }.to raise_error(IndexError)
    end

    it "should fail to update non-existant app" do
      expect { subject.update(name: app_name3, app: { name: app_name4 }) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe ".destroy" do
    it "should fail to destroy non-existant app" do
      expect { subject.destroy(name: app_name3) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe ".restart" do
    it "should fail to restart a non existant app" do
      expect { subject.restart(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe ".logs" do
    it "should fail to retrieve logs uri for a non existant app" do
      expect { subject.logs(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe "#restart" do
    it "should restart the the app" do
      app.restart
    end
  end

  describe "#logs" do
    it "should retrieve logs url for app" do
      app.logs
    end
  end

  describe "#scale" do
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

  describe "#gears" do
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
    it "should have drains" do
      expect(app.drains).to be_an_instance_of(Dawn::App::Drains)
    end

    it "should retrieve drains" do
      app.drains.all
    end
  end

  describe "#domains" do
    it "should have domains" do
      expect(app.domains).to be_an_instance_of(Dawn::App::Domains)
    end

    it "should retrieve domains" do
      app.domains.all
    end
  end

  describe "#releases" do
    it "should have releases" do
      expect(app.releases).to be_an_instance_of(Dawn::App::Releases)
    end

    it "should retrieve releases" do
      app.releases.all
    end
  end

  describe "#update" do
    it "should update 1 app" do
      app = subject.find(name: "cookie-crushers")
      app.update(app: { name: "bread-crushers" })
    end
  end

  describe "#destroy" do
    it "should destroy 1 app" do
      app = subject.find(name: "bread-crushers")
      app.destroy(name: "bread-crushers")
    end
  end
end
