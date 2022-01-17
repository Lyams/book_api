require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "DELETE #destroy" do
    let(:user2){create :user2}
    let!(:product){create(:product)}
    it "should destroy a product" do
      expect{delete api_v1_product_url(product),
                    headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }
      }.to change { Product.count }.by(-1)
      expect(response).to have_http_status(:no_content)
    end
    it "should forbid destroy a product" do
      expect { delete api_v1_product_url(product),
                    headers: { Authorization: JsonWebToken.encode(user_id: user2.id) }
      }.to change { Product.count }.by(0)
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "PATCH #update" do
    let(:product){create :product}
    let(:user2){create :user2}
    it "should update a product" do
      patch api_v1_product_url(product),
            params:  { product: {title: product.title.reverse }},
            headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }
      expect(response).to have_http_status(:success)
    end
    it "should forbid update a product" do
      patch api_v1_product_url(product),
            params:  { product: {title: product.title.reverse }},
            headers: { Authorization: JsonWebToken.encode(user_id: user2.id) }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "POST #create" do
    let(:user){create :user}
    let(:product){build :product}
    it "should create a product" do
      post api_v1_products_url,
           params: { product: {title: product.title,
                               price: product.price,
                               published: product.published}},
           headers: { Authorization: JsonWebToken.encode(user_id: user.id)}
      expect(response).to have_http_status(:created)
    end
  end

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
