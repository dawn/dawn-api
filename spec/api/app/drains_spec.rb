require_relative '../../api_spec_helper.rb'

describe Dawn::App::Drains do
  before(:suite) do
    Dawn::App.create(name: "drains-test-app")
  end

  let(:app) { Dawn::App.find(name: "drains-test-app") }
  let(:drains) { app.drains }

  ###
  context "#all" do
    it "should return all drains" do
      drains.all
    end
    it "should have only drains" do
      drains.all.all? { |drain| expect(drain).to be_an_instance_of Dawn::Drain }
    end
  end

  context "#create" do
    it "should create a new drain" do
      drains.create
    end
  end

  ###
  after(:suite) do
    Dawn::App.find(name: "drains-test-app").destroy
  end
end
