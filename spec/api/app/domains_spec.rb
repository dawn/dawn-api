require 'api_spec_helper'

describe Dawn::App::Domains, :vcr do
  subject { Dawn::App::Domains }

  let(:app) { Dawn::App.find(name: "domains-test") }

  it { should be_a Class }

  ###
  context "#all" do
    subject { app.domains }

    it "should return all domains" do
      subject.all
    end

    it "should have only domains" do
      subject.all.all? { |domain| expect(domain).to be_an_instance_of(Dawn::Domain) }
    end
  end

  context "#create" do
    subject { app.domains }

    it "should create a new domain" do
      subject.create(domain: { url: "http://wearepeople.io" })
    end
  end
end
