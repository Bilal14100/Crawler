require 'rails_helper'

RSpec.describe "Api::V1::AmazonSerpsController", type: :request do
  context "Authenticated GET /index" do
    include_context 'user_jwt_token'
    before do
      5.times do
        FactoryBot.create(:amazon_serp)
      end
    end
    it "return all amazon_serps and 200 status" do
      get "/api/v1/amazon_serps", headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response["amazon_serps"].first.keys).to eq(["id","url", "active", "parsed_at"])
      expect(json_response["amazon_serps"].length).to eq(5)
    end
  end

  context "Unauthenticated GET /index" do
    it "should not allow unauthenticated user" do
      get "/api/v1/amazon_serps", as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
