require 'api_spec_helper'

describe Dawn::Domain, :vcr do
  subject { Dawn::Domain }

  before :all do
    $test_store.test_domain_app ||= Dawn::App.find(id: $test_store.ref["apps"]["domain-test"])
    $test_store.test_domain1 ||= Dawn::Domain.find(id: $test_store.ref["domains"]["cc-rushers.io"])
    $test_store.test_domain2 ||= Dawn::Domain.find(id: $test_store.ref["domains"]["cookiecrushers.com"])
    $test_store.test_domain3 ||= Dawn::Domain.find(id: $test_store.ref["domains"]["cookie-crusher.net"])
  end

  after :all do
    $test_store.delete_field(:test_domain1) rescue nil
    $test_store.delete_field(:test_domain2) rescue nil
    $test_store.delete_field(:test_domain3) rescue nil
  end

  it { should be_a Class }

  describe ".find" do
    it "should raise an Excon::Errors::NotFound when Domain cannot be found" do
      expect { subject.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 domain by id" do
      subject.find(id: $test_store.test_domain1.id)
    end

    it "should find 1 domain by url" do
      subject.find(url: $test_store.test_domain2.url)
    end
  end

  describe ".destroy" do
    it "should raise an Excon::Errors::NotFound when Domain cannot be found" do
      expect { subject.destroy(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 domain by id" do
      subject.destroy(id: $test_store.test_domain1.id)
    end

    it "should destroy 1 domain by url" do
      subject.destroy(url: $test_store.test_domain2.url)
    end
  end

  describe "#destroy" do
    it "should destroy the domain" do
      $test_store.test_domain3.destroy
    end
  end
end
