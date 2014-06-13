require_relative '../../api_spec_helper.rb'

describe Dawn::App::Releases do
  before(:suite) do
    Dawn::App.create(name: "releases-test-app")
  end

  let(:app) { Dawn::App.find(name: "releases-test-app") }
  let(:releases) { app.releases }

  ###
  context "#all" do
    it "should return all releases" do
      releases.all
    end
    it "should have only releases" do
      releases.all.all? { |release| expect(release).to be_an_instance_of Dawn::Release }
    end
  end

  context "#create" do
    it "should create a new release" do
      releases.create
    end
  end

  ###
  after(:suite) do
    Dawn::App.find(name: "releases-test-app").destroy
  end
end
