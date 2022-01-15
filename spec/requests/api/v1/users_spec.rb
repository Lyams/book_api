require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user) }
  describe "GET #show" do
    it "should show user" do
      get api_v1_user_url(user)
      expect(response).to have_http_status :success
      expect((JSON::parse response.body)["email"]).to eq user.email
    end
  end
end
