require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "Authenticated GET /index" do
    include_context 'user_jwt_token'
    before do
      5.times do
        FactoryBot.create(:product)
      end
    end
    it "return all products and 200 status" do
      get "/api/v1/products", headers: {"Authorization"=> "Bearer #{@token}"}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response["products"].length).to eq(5)
    end
  end

  describe "Unauthenticated GET /index" do
    it "return all products and 200 status" do
      get "/api/v1/products", as: :json
      expect(response.status).to eq(403)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
      # expect(json_response["products"].length).to eq(5)
    end
  end
end
