require 'api_spec_helper'

describe Dawn::App::Releases, :vcr do
  subject { Dawn::App::Releases }

  let(:app) { Dawn::App.find(name: "releases-test") }

  it { should be_a Class }

  ###
  context "#all" do
    subject { app.releases }

    it "should return all releases" do
      subject.all
    end

    it "should have only releases" do
      subject.all.all? { |release| expect(release).to be_an_instance_of(Dawn::Release) }
    end
  end

  context "#create" do
    subject { app.releases }

    it "should create a new release" do
      subject.create
    end
  end
end
