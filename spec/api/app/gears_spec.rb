require 'api_spec_helper'

describe Dawn::App::Gears, :vcr do
  subject { Dawn::App::Gears }

  let(:app) { Dawn::App.find(name: "gears-test") }

  it { should be_a Class }

  ###
  context "#all" do
    subject { app.gears }

    it "should return all gears" do
      subject.all
    end

    it "should have only gears" do
      subject.all.all? { |gear| expect(gear).to be_an_instance_of(Dawn::Gear) }
    end
  end

  context "#restart" do
    subject { app.gears }

    it "should restart all gears" do
      subject.restart
    end
  end

  context "#create" do
    subject { app.gears }

    it "should create a new gear" do
      subject.create
    end
  end
end
