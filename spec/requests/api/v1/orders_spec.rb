require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  let(:order) { create :order }
  let(:product) { build :product }
  let(:product_keda) { create :product_keda }
  before { product.user = order.user; product.save; order.update(products: [product]) }

  describe "POST #create" do
    before { @order_params = { order:
                                 { product_ids_and_quantities:
                                     [ { product_id: product.id, quantity: 2 },
                                     { product_id: product_keda.id, quantity: 3 } ]
                                 } } }
    it 'should create order with two products and placements' do
      expect{ post api_v1_orders_url,
                   params: @order_params,
                   headers: { Authorization: JsonWebToken.encode(user_id: order.user_id)}}
        .to change { Order.count }.by(1)
      expect(Order.last.products.count).to eq(2)
      expect(Order.last.placements.count).to eq(2)
      expect(response).to have_http_status(:created)
    end
    it "should forbid create order for unlogged" do
      expect{ post api_v1_orders_url, params: @order_params}.not_to change { Order.count }
      expect(response).to have_http_status(:forbidden)
    end

  end

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
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:links, :first)).not_to be_nil
      expect(json_response.dig(:links, :last)).not_to be_nil
      expect(json_response.dig(:links, :prev)).not_to be_nil
      expect(json_response.dig(:links, :next)).not_to be_nil
    end
  end
end
