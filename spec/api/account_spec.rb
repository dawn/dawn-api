require_relative '../api_spec_helper.rb'

describe Dawn::Account do
  let(:account) { Dawn::Account.current }
  describe "::current" do
    it "should retrieve current user account" do
      Dawn::Account.current
    end
  end
  describe "#update" do
    it "should update an account" do
      account.update username: "HexenDaigen"
    end
  end
end
