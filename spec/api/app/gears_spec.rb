require_relative '../../api_spec_helper.rb'

describe Dawn::App::Gears do
  before(:suite) do
    Dawn::App.create(name: "gears-test-app")
  end

  let(:app) { Dawn::App.find(name: "gears-test-app") }
  let(:gears) { app.gears }

  ###
  context "#all" do
    it "should return all gears" do
      gears.all
    end
    it "should have only gears" do
      gears.all.all? { |gear| expect(gear).to be_an_instance_of Dawn::Gear }
    end
  end

  context "#restart" do
    it "should restart all gears" do
      gears.restart
    end
  end

  context "#create" do
    it "should create a new gear" do
      gears.create
    end
  end

  ###
  after(:suite) do
    Dawn::App.find(name: "gears-test-app").destroy
  end
end
