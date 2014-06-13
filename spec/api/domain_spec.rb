require_relative '../api_spec_helper.rb'

describe Dawn::Domain do
  let(:domain) { Dawn::Domain }

  context "::find" do
    it "should find 1 domain by id" do
      domain.find id: 1
    end
    it "should find 1 domain by url" do
      domain.find url: "cookiecrushers"
    end
  end

  context "#destroy" do
    it "should destroy 1 domain by id" do
      domain.destroy id: 1
    end
    it "should destroy 1 domain by url" do
      domain.destroy url: "cookiecrushers"
    end
  end
end
