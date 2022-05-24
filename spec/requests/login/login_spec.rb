require 'rails_helper'

RSpec.describe "Login", type: :request do
  let(:user) {FactoryBot.create(:user)}

  context "Valid credentials" do
    it "returns jwt token with 200 status" do
      post "/api/v1/login", params: {username: user.username, password: user.password}, headers: {}, as: :json
      expect(response.status).to eq(200)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("token")
    end
  end

  context "Wrong credentials" do
    it "returns 422 status and message" do
      post "/api/v1/login", params: {username: user.username, password: "wrong password"}, headers: {}, as: :json
      expect(response.status).to eq(401)
      json_response = JSON.parse response.body
      expect(json_response).to have_key("error")
    end
  end
end
