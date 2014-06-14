require_relative '../api_spec_helper.rb'

describe Dawn::Gear do
  before :all do
    STDERR.puts "initializing"
    Dawn::App.safe.create(app: { name: "gear-test-app" })
    app = $test_store.test_gear_app ||= Dawn::App.find(name: "gear-test-app")
    $test_store.test_gear1 ||= app.gears.create(gear: { url: "flushme.io" })
    $test_store.test_gear2 ||= app.gears.create(gear: { url: "toil.com" })
    $test_store.test_gear3 ||= app.gears.create(gear: { url: "downthegear.net" })
  end

  context ".find" do
    it "should raise an Excon::Errors::NotFound when Gear cannot be found" do
      expect { Dawn::Gear.find(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end

    it "should find 1 gear by id" do
      Dawn::Gear.find id: $test_store.test_gear1.id
    end

    it "should find 1 gear by url" do
      Dawn::Gear.find url: $test_store.test_gear2.url
    end
  end

  context ".destroy" do
    it "should raise an Excon::Errors::NotFound when Gear cannot be found" do
      expect { Dawn::Gear.destroy id: -1 }.to raise_error(Excon::Errors::NotFound)
    end

    it "should destroy 1 gear by id" do
      Dawn::Gear.destroy id: $test_store.test_gear1.id
    end

    it "should destroy 1 gear by url" do
      Dawn::Gear.destroy url: $test_store.test_gear2.url
    end
  end

  context "#restart" do
    it "should restart 1 gear by id" do
      Dawn::Gear.restart id: 1
    end
    it "should 404 if gear does not exist" do
      expect { Dawn::Gear.restart(id: -1) }.to raise_error(Excon::Errors::NotFound)
    end
  end

  context "#destroy" do
    it "should destroy the gear" do
      $test_store.test_gear3.destroy
    end
  end

  after :all do
    STDERR.puts "cleaning up"
    $test_store.delete_field(:test_gear1) rescue nil
    $test_store.delete_field(:test_gear2) rescue nil
    $test_store.delete_field(:test_gear3) rescue nil
    $test_store.test_gear_app.destroy rescue nil
  end
end
