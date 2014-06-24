require 'api_spec_helper'

describe Dawn::Drain, :vcr do
  subject { Dawn::Drain }

  before :all do
    $test_store.test_drain_app ||= Dawn::App.find(id: $test_store.ref["apps"]["drain-test"])
    $test_store.test_drain1 ||= Dawn::Drain.find(id: $test_store.ref["drains"]["flushme.io"])
    $test_store.test_drain2 ||= Dawn::Drain.find(id: $test_store.ref["drains"]["toil.com"])
    $test_store.test_drain3 ||= Dawn::Drain.find(id: $test_store.ref["drains"]["downthedrain.net"])
  end

  after :all do
    $test_store.delete_field(:test_drain1) rescue nil
    $test_store.delete_field(:test_drain2) rescue nil
    $test_store.delete_field(:test_drain3) rescue nil
  end

  it { should be_a Class }

  describe ".find" do
    it "should raise an Excon::Errors::NotFound when Drain cannot be found" do
      expect { subject.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 drain by id" do
      subject.find id: $test_store.test_drain1.id
    end

    it "should find 1 drain by url" do
      subject.find url: $test_store.test_drain2.url
    end
  end

  describe ".destroy" do
    it "should raise an Excon::Errors::NotFound when Drain cannot be found" do
      expect { subject.destroy(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 drain by id" do
      subject.destroy(id: $test_store.test_drain1.id)
    end

    it "should destroy 1 drain by url" do
      subject.destroy(url: $test_store.test_drain2.url)
    end
  end

  describe "#destroy" do
    it "should destroy the drain" do
      $test_store.test_drain3.destroy
    end
  end
end
