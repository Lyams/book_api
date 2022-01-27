require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { build(:user) }

  describe "GET #show" do
    before { user.save }
    let(:product) { build(:product, user_id: user.id) }
    it "should show user" do
      product.save
      get api_v1_user_url(user)
      expect(response).to have_http_status :success
      json_response = JSON::parse(self.response.body, symbolize_names: true)
      expect(json_response.dig(:data, :attributes, :email)).to eq(user.email)
      expect(json_response.dig(:data, :relationships, :products, :data, 0, :id)).to eq(user.products.first.id.to_s)
      expect(json_response.dig(:included, 0, :attributes, :title)).to eq(user.products.first.title)
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
  describe "PATCH #update" do
    before { user.save }
    it "should update user email" do
      patch api_v1_user_url(user), params: {
        user: { email: ("AV" + user.email), password: user.password } },
            headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response.status).to eq(200)
    end

    it "should forbid update user" do
      patch api_v1_user_url(user), params: {
        user: { email: ("AV" + user.email), password: user.password } }
      expect(response).to have_http_status(:forbidden)
    end

    it "should not update user with invalide email" do
      patch api_v1_user_url(user), params: {
        user: { email: "aaa.asss", password: "234" } },
            headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response.status).to eq(422)
    end
  end

  describe "DELETE #destroy" do
    before { user.save }
    let(:product) { build(:product) }
    it "should destroy user" do
      expect { delete api_v1_user_url(user),
                      headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      }.to change { User.count }.by(-1)
      expect(response.status).to eq 204
    end
    it 'should forbid destroy user' do
      expect { delete api_v1_user_url(user) }.not_to change { User.count }
    end
    it 'destroy user should destroy linked product' do
      product.user = user
      product.save
      expect { user.destroy }.to change { Product.count }.by(-1)
    end
  end
end
