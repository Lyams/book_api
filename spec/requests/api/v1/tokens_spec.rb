require 'rails_helper'

RSpec.describe "Api::V1::Tokens", type: :request do
  describe "POST #create" do
    let!(:user) { create :user }
    it "should get JWT token" do
      post api_v1_tokens_url, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['token']).to_not be_nil
    end
    it "should not get JWT token" do
      post api_v1_tokens_url, params: { user: { email: user.email, password: "Wrong_PASSWORD" } }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq("")
    end
  end

end
