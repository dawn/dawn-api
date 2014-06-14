require_relative '../api_spec_helper.rb'

describe Dawn::Drain do
  before :all do
    STDERR.puts "initializing"
    Dawn::App.safe.create(app: { name: "drain-test-app" })
    app = $test_store.test_drain_app ||= Dawn::App.find(name: "drain-test-app")
    $test_store.test_drain1 ||= app.drains.create(drain: { url: "flushme.io" })
    $test_store.test_drain2 ||= app.drains.create(drain: { url: "toil.com" })
    $test_store.test_drain3 ||= app.drains.create(drain: { url: "downthedrain.net" })
  end

  context ".find" do
    it "should raise an Excon::Errors::NotFound when Drain cannot be found" do
      expect { Dawn::Drain.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 drain by id" do
      Dawn::Drain.find id: $test_store.test_drain1.id
    end

    it "should find 1 drain by url" do
      Dawn::Drain.find url: $test_store.test_drain2.url
    end
  end

  context ".destroy" do
    it "should raise an Excon::Errors::NotFound when Drain cannot be found" do
      expect { Dawn::Drain.destroy id: -1 }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 drain by id" do
      Dawn::Drain.destroy id: $test_store.test_drain1.id
    end

    it "should destroy 1 drain by url" do
      Dawn::Drain.destroy url: $test_store.test_drain2.url
    end
  end

  context "#destroy" do
    it "should destroy the drain" do
      $test_store.test_drain3.destroy
    end
  end

  after :all do
    STDERR.puts "cleaning up"
    $test_store.delete_field(:test_drain1) rescue nil
    $test_store.delete_field(:test_drain2) rescue nil
    $test_store.delete_field(:test_drain3) rescue nil
    $test_store.test_drain_app.destroy rescue nil
  end
end
