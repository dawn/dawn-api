require 'api_spec_helper'

describe Dawn::Release, :vcr do
  subject { Dawn::Release }

  it { should be_a Class }

  describe ".find" do
    it "should find 1 release by id" do
      subject.find(id: 1)
    end
  end
end
