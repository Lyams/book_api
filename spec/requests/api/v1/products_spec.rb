require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET #show" do
    let(:product) {create :product}
    it "should show product" do
      get api_v1_product_url(product)
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(self.response.body)
      expect(json_response['title']).to eq(product.title)
    end
  end
  describe "GET #index" do
    let(:product) {create :product}
    it "should show products" do
      get api_v1_products_url
      expect(response).to have_http_status(:success)
    end
  end
end
