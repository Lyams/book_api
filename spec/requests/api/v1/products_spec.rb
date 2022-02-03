# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
  describe 'DELETE #destroy' do
    let(:user2) { create :user2 }
    let!(:product) { create(:product) }

    it 'destroys a product' do
      expect do
        delete api_v1_product_url(product),
               headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }
      end.to change(Product, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'forbids destroy a product' do
      expect do
        delete api_v1_product_url(product),
               headers: { Authorization: JsonWebToken.encode(user_id: user2.id) }
      end.to change(Product, :count).by(0)
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH #update' do
    let(:product) { create :product }
    let(:user2) { create :user2 }

    it 'updates a product' do
      patch api_v1_product_url(product),
            params: { product: { title: product.title.reverse } },
            headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }
      expect(response).to have_http_status(:success)
    end

    it 'forbids update a product' do
      patch api_v1_product_url(product),
            params: { product: { title: product.title.reverse } },
            headers: { Authorization: JsonWebToken.encode(user_id: user2.id) }
      expect(response).to have_http_status(:forbidden)
    end

    it 'errors update product' do
      patch api_v1_product_url(product),
            params: { product: { title: nil } },
            headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST #create' do
    let(:user) { create :user }
    let(:product) { build :product }

    it 'creates a product' do
      post api_v1_products_url,
           params: { product: { title: product.title,
                                price: product.price,
                                published: product.published } },
           headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response).to have_http_status(:created)
    end

    it 'errorses create a product' do
      post api_v1_products_url,
           params: { product: { title: product.title,
                                price: -1,
                                published: product.published } },
           headers: { Authorization: JsonWebToken.encode(user_id: user.id) }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #show' do
    let(:product) { create :product }

    it 'shows product' do
      get api_v1_product_url(product)
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:data, :attributes, :title)).to eq(product.title)
      expect(json_response.dig(:data, :relationships, :user, :data, :id)).to eq(product.user.id.to_s)
      expect(json_response.dig(:included, 0, :attributes, :email)).to eq(product.user.email)
    end
  end

  describe 'GET #index' do
    let!(:product) { create :product }
    let!(:product_keda) { create :product_keda }

    it 'shows products' do
      get api_v1_products_url
      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body, symbolize_names: true)
      expect(json_response.dig(:links, :first)).not_to be_nil
      expect(json_response.dig(:links, :last)).not_to be_nil
      expect(json_response.dig(:links, :prev)).not_to be_nil
      expect(json_response.dig(:links, :next)).not_to be_nil
    end

    it 'filters products by name' do
      expect(Product.filter_by_title('tv').sort).to eq([product, product_keda])
      expect(Product.filter_by_title('tv').count).to eq(2)
      expect(Product.filter_by_title('Mnogo vsyakoy lagi, i dage ligi').count).to eq(0)
    end

    it 'filters products by price' do
      expect(Product.above_or_equal_to_price(6000.0)).to eq([product])
      expect(Product.above_or_equal_to_price(0.0).count).to eq(Product.count)
    end

    it 'filters products by price lower' do
      expect(Product.below_or_equal_to_price(6000.0)).to eq([product_keda])
      expect(Product.below_or_equal_to_price(1_000_000_000.0).count).to eq(Product.count)
    end

    it 'sorts product by most recent' do
      product.touch
      expect(Product.recent.to_a).to eq([product_keda, product])
    end

    it 'search hash' do
      search_hash_empty = { keyword: 'tv', min_price: 1_000_000.0 }
      search_hash = { keyword: 'tv', min_price: 100.0 }
      search_hash_keda = { keyword: 'tv', min_price: 100.0, max_price: 10_000.0 }
      search_hash_product = { keyword: 'tv', min_price: 10_000.0 }
      expect(Product.search(search_hash_empty)).to be_empty
      expect(Product.search(search_hash_keda)).to eq([product_keda])
      expect(Product.search(search_hash_product)).to eq([product])
      expect(Product.search(search_hash)).to eq([product, product_keda])
    end
  end
end
