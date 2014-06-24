require 'api_spec_helper'

describe Dawn::Gear, :vcr do
  subject { Dawn::Gear }

  before :all do
    $test_store.test_gear_app ||= Dawn::App.find(id: $test_store.ref["apps"]["gear-test"])
    $test_store.test_gear1 ||= Dawn::Gear.find(id: $test_store.ref["gears"][0])
    $test_store.test_gear2 ||= Dawn::Gear.find(id: $test_store.ref["gears"][1])
    $test_store.test_gear3 ||= Dawn::Gear.find(id: $test_store.ref["gears"][2])
  end

  after :all do
    STDERR.puts "cleaning up"
    $test_store.delete_field(:test_gear1) rescue nil
    $test_store.delete_field(:test_gear2) rescue nil
    $test_store.delete_field(:test_gear3) rescue nil
  end

  it { should be_a Class }

  describe ".find" do
    it "should raise an Excon::Errors::NotFound when Gear cannot be found" do
      expect { subject.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 gear by id" do
      subject.find(id: $test_store.test_gear1.id)
    end

    it "should find 1 gear by url" do
      subject.find(url: $test_store.test_gear2.url)
    end
  end

  describe ".destroy" do
    it "should raise an Excon::Errors::NotFound when Gear cannot be found" do
      expect { subject.destroy(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 gear by id" do
      subject.destroy(id: $test_store.test_gear1.id)
    end

    it "should destroy 1 gear by url" do
      subject.destroy(url: $test_store.test_gear2.url)
    end
  end

  describe ".restart" do
    it "should restart 1 gear by id" do
      subject.restart(id: 1)
    end

    it "should 404 if gear does not exist" do
      expect { subject.restart(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  describe "#destroy" do
    it "should destroy the gear" do
      $test_store.test_gear3.destroy
    end
  end
end
