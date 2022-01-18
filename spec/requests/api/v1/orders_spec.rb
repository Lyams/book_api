require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  let(:order){create :order}
  let(:product){build :product}
  before {product.user = order.user; product.save; order.update(products: [product])}
  
  describe "GET #show" do
    it 'should show order' do
      get api_v1_order_url(order),
          headers: { Authorization: JsonWebToken.encode(user_id: order.user_id)}, as: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      include_product_attr = json_response['included'][0]['attributes']
      expect(include_product_attr['title']).to eq(order.products.first.title)
    end
    it 'should forbid show order' do
      get api_v1_order_url(order), as: :json
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "GET #index" do
    it "should forbid orders for unlogged" do
      get api_v1_orders_url, as: :json
      expect(response).to have_http_status(:forbidden)
    end
    it "should show orders" do
      get api_v1_orders_url, headers: { Authorization: JsonWebToken.encode(user_id: order.user_id)}, as: :json
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['data'].count).to eq(order.user.orders.count)
    end
  end
end
