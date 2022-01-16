require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { build(:user) }
  describe "GET #show" do
    it "should show user" do
      user.save
      get api_v1_user_url(user)
      expect(response).to have_http_status :success
      expect((JSON::parse response.body)["email"]).to eq user.email
    end
  end

  describe "POST #create" do
    it "should create user" do
      expect { post api_v1_users_url, params: {
        user: { email: user.email, password: user.password } } }.to change { User.count }.by(1)
      expect(response.status).to eq 201
    end
    context 'invalid data' do
      before { user.save }
      it "should not create user with taken email" do
        expect { post api_v1_users_url, params: {
          user: { email: user.email, password: "234" } } }.to change { User.count }.by(0)
        expect(response.status).to eq(422)
      end
    end
  end
end
