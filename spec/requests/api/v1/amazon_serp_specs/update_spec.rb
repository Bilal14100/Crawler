require 'rails_helper'

RSpec.describe "Api::V1::AmazonSerpsController", type: :request do
  let(:amazon_serp) {FactoryBot.create(:amazon_serp)}
  context "Authenticated GET /update" do
    include_context 'user_jwt_token'
    
    it "updates an amazon_serps and 200 status" do
      put "/api/v1/amazon_serps/#{amazon_serp.id}", params:{amazon_serp: {active: false}},headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response.keys).to eq(["id", "url", "active", "parsed_at"])
    end

    it "should return proper response when validation failed" do
      post "/api/v1/amazon_serps", params:{amazon_serp: {url: "wrong url"}},headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(422)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("errors")
    end
  end

  context "Unauthenticated GET /update" do
    it "should not allow unauthenticated user" do
      put "/api/v1/amazon_serps/#{amazon_serp.id}", params:{amazon_serp: {active: false}}, as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
