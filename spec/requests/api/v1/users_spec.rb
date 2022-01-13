require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let!(:user) { User.create(email: "example@example.com", password_digest: "00000") }
  describe "GET #show" do
    it "should show user" do
      get api_v1_user_url(user)
      expect(response).to have_http_status :success
    end
  end
end
