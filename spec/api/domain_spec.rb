require_relative '../api_spec_helper.rb'

describe Dawn::Domain do
  before :all do
    STDERR.puts "initializing"
    Dawn::App.safe.create(app: { name: "domain-test-app" })
    app = $test_store.test_domain_app ||= Dawn::App.find(name: "domain-test-app")
    $test_store.test_domain1 ||= app.domains.create(domain: { url: "cc-rushers.io" })
    $test_store.test_domain2 ||= app.domains.create(domain: { url: "cookiecrushers.com" })
    $test_store.test_domain3 ||= app.domains.create(domain: { url: "cookie-crusher.net" })
  end

  context ".find" do
    it "should raise an Excon::Errors::NotFound when Domain cannot be found" do
      expect { Dawn::Domain.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 domain by id" do
      Dawn::Domain.find id: $test_store.test_domain1.id
    end

    it "should find 1 domain by url" do
      Dawn::Domain.find url: $test_store.test_domain2.url
    end
  end

  context ".destroy" do
    it "should raise an Excon::Errors::NotFound when Domain cannot be found" do
      expect { Dawn::Domain.destroy id: -1 }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 domain by id" do
      Dawn::Domain.destroy id: $test_store.test_domain1.id
    end

    it "should destroy 1 domain by url" do
      Dawn::Domain.destroy url: $test_store.test_domain2.url
    end
  end

  context "#destroy" do
    it "should destroy the domain" do
      $test_store.test_domain3.destroy
    end
  end

  after :all do
    STDERR.puts "cleaning up"
    $test_store.delete_field(:test_domain1) rescue nil
    $test_store.delete_field(:test_domain2) rescue nil
    $test_store.delete_field(:test_domain3) rescue nil
    $test_store.test_domain_app.destroy rescue nil
  end
end
