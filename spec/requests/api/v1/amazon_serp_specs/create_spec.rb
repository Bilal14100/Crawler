require 'rails_helper'

RSpec.describe "Api::V1::AmazonSerpsController", type: :request do
  let(:valid_amazon_attributes) {attributes_for(:amazon_serp)}
  describe "Authenticated GET /create" do
    include_context 'user_jwt_token'
    let(:invalid_amazon_attributes) {attributes_for(:amazon_serp, url: "")}
    
    it "creates an amazon_serps and 200 status" do
      post "/api/v1/amazon_serps", params:{amazon_serp: valid_amazon_attributes},headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response.keys).to eq(["id", "url", "active", "parsed_at"])
    end

    it "should return proper response when validation failed" do
      post "/api/v1/amazon_serps", params:{amazon_serp: invalid_amazon_attributes},headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(422)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("errors")
    end
  end

  describe "Unauthenticated GET /create" do
    it "should not allow unauthenticated user" do
      post "/api/v1/amazon_serps", params:{amazon_serp: valid_amazon_attributes}, as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
