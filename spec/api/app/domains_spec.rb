require_relative '../../api_spec_helper.rb'

describe Dawn::App::Domains do
  before(:suite) do
    Dawn::App.create(name: "domains-test-app")
  end

  let(:app) { Dawn::App.find(name: "domains-test-app") }
  let(:domains) { app.domains }

  ###
  context "#all" do
    it "should return all domains" do
      domains.all
    end
    it "should have only domains" do
      domains.all.all? { |domain| expect(domain).to be_an_instance_of Dawn::Domain }
    end
  end

  context "#create" do
    it "should create a new domain" do
      domains.create
    end
  end

  ###
  after(:suite) do
    Dawn::App.find(name: "domains-test-app").destroy
  end
end
