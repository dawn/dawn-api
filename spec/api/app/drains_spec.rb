require 'api_spec_helper'

describe Dawn::App::Drains, :vcr do
  subject { Dawn::App::Drains }

  let(:app) { Dawn::App.find(name: "drains-test") }

  it { should be_a Class }

  ###
  context "#all" do
    subject { app.drains }

    it "should return all drains" do
      subject.all
    end

    it "should have only drains" do
      subject.all.all? { |drain| expect(drain).to be_an_instance_of(Dawn::Drain) }
    end
  end

  context "#create" do
    subject { app.drains }

    it "should create a new drain" do
      subject.create(drain: { url: "http://flush.it" })
    end
  end
end
