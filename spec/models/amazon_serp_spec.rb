require 'rails_helper'

RSpec.describe AmazonSerp, type: :model do
  describe "Validation" do
    let(:invalid_amazon_serp){FactoryBot.build(:amazon_serp, url: "not a url")}
    let(:valid_amazon_serp){FactoryBot.build(:amazon_serp)}
    context "Invalid" do
      it "should not be valid with wrong url" do
        expect(invalid_amazon_serp).not_to be_valid
      end
    end

    context "valid page" do
      it "should not be valid with wrong url" do
        expect(valid_amazon_serp).to be_valid
      end
    end
  end
end
