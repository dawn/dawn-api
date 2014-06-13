require_relative '../api_spec_helper.rb'

describe Dawn::Gear do
  let(:gear) { Dawn::Gear }

  context "::find" do
    it "should find 1 gear by id" do
      gear.find id: 1
    end
  end

  context "#restart" do
    it "should restart 1 gear by id" do
      gear.find id: 1
    end
  end

  context "#destroy" do
    it "should destroy 1 gear by id" do
      gear.destroy id: 1
    end
  end
end
