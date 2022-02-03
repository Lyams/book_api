# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { build(:user) }

  describe 'GET #show' do
    before { user.save }

    let(:product) { build(:product, user_id: user.id) }

    it 'shows user' do
      product.save
      get api_v1_user_url(user)
      expect(response).to have_http_status :success
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data, :attributes, :email)).to eq(user.email)
      expect(json_response.dig(:data, :relationships, :products, :data, 0, :id)).to eq(user.products.first.id.to_s)
      expect(json_response.dig(:included, 0, :attributes, :title)).to eq(user.products.first.title)
    end
  end

  describe 'POST #create' do
    it 'creates user' do
      expect do
        post api_v1_users_url, params: {
          user: { email: user.email, password: user.password }
        }
      end.to change(User, :count).by(1)
      expect(response.status).to eq 201
    end

    context 'invalid data' do
      before { user.save }

      it 'does not create user with taken email' do
        expect do
          post api_v1_users_url, params: {
            user: { email: user.email, password: '234' }
          }
        end.to change(User, :count).by(0)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH #update' do
    before { user.save }

    it 'updates user email' do
      patch api_v1_user_url(user), params: {
        user: { email: "AV#{user.email}", password: user.password }
      },
                                   headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response.status).to eq(200)
    end

    it 'forbids update user' do
      patch api_v1_user_url(user), params: {
        user: { email: "AV#{user.email}", password: user.password }
      }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not update user with invalide email' do
      patch api_v1_user_url(user), params: {
        user: { email: 'aaa.asss', password: '234' }
      },
                                   headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE #destroy' do
    before { user.save }

    let(:product) { build(:product) }

    it 'destroys user' do
      expect do
        delete api_v1_user_url(user),
               headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      end.to change(User, :count).by(-1)
      expect(response.status).to eq 204
    end

    it 'forbids destroy user' do
      expect { delete api_v1_user_url(user) }.not_to change(User, :count)
    end

    it 'destroy user should destroy linked product' do
      product.user = user
      product.save
      expect { user.destroy }.to change(Product, :count).by(-1)
    end
  end
end
