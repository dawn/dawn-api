require 'api_spec_helper'

describe Dawn::Account, :vcr do
  subject { Dawn::Account }

  it { should be_a Class }

  describe ".current" do
    it "should retrieve current user account" do
      Dawn::Account.current
    end
  end

  describe "#update" do
    subject { Dawn::Account.current }

    it "should update an account" do
      subject.update(account: { username: "MyNameIs" })
    end
  end
end
