require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /index" do
    let(:order) { create(:order)}
    let(:product) {build(:product)}
    it "should forbid orders for unlogged" do
      get api_v1_orders_url, as: :json
      expect(response).to have_http_status(:forbidden)
    end
    it "should show orders" do
      product.user = order.user
      order.update(products: [product])
      get api_v1_orders_url, headers: { Authorization: JsonWebToken.encode(user_id: order.user_id)}, as: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].count).to eq(order.user.orders.count)
    end
  end
end
