require 'rails_helper'

RSpec.describe "Api::V1::AmazonSerpsController", type: :request do
  let(:amazon_serp) {FactoryBot.create(:amazon_serp)}
  describe "Authenticated GET /delete" do
    include_context 'user_jwt_token'
    
    it "deletes an amazon_serps and 200 status" do
      amazon_serp
      expect(AmazonSerp.count).to eq(1)
      delete "/api/v1/amazon_serps/#{amazon_serp.id}",headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      expect(AmazonSerp.count).to eq(0)
      json_response = JSON.parse response.body
      expect(json_response.keys).to eq(["message"])
    end
    
  end

  describe "Unauthenticated GET /delete" do
    it "should not allow unauthenticated user" do
      delete "/api/v1/amazon_serps/#{amazon_serp.id}", as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
