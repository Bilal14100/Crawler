require 'rails_helper'

RSpec.describe "Api::V1::AmazonSerpsController", type: :request do
  let(:amazon_serp){FactoryBot.create(:amazon_serp)}
  context "Authenticated GET /show" do
    include_context 'user_jwt_token'
    it "return all amazon_serps and 200 status" do
      get "/api/v1/amazon_serps/#{amazon_serp.id}", headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("id")
      expect(json_response).to have_key("url")
      expect(json_response).to have_key("active")
      expect(json_response).to have_key("parsed_at")
    end
  end

  context "Unauthenticated GET /show" do
    it "should not allow unauthenticated user" do
      get "/api/v1/amazon_serps/#{amazon_serp.id}", as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
