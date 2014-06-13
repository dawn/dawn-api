require_relative '../api_spec_helper.rb'

describe Dawn::Drain do
  let(:drain) { Dawn::Drain }

  context "::find" do
    it "should find 1 drain by id" do
      drain.find id: 1
    end
  end

  context "#destroy" do
    it "should destroy 1 drain by id" do
      drain.destroy id: 1
    end
  end
end
