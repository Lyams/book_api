# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  describe 'POST #create' do
    let!(:user) { create :user }

    it 'gets JWT token' do
      post api_v1_tokens_url, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['token']).not_to be_nil
    end

    it 'does not get JWT token' do
      post api_v1_tokens_url, params: { user: { email: user.email, password: 'Wrong_PASSWORD' } }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to eq('')
    end
  end
end
