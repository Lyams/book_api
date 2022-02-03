# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include Paginable
      before_action :set_product, only: %i[update show destroy]
      before_action :check_login, only: %i[create]
      before_action :check_owner, only: %i[update destroy]

      def show
        options = { include: [:user] }
        render json: ProductSerializer.new(@product, options).serializable_hash
      end

      def index
        @products = Product.includes(:user).page(current_page).per(per_page).search(params)
        options = get_links_serializer_options 'api_v1_products_path', @products
        options[:include] = [:user]
        render json: ProductSerializer.new(@products, options).serializable_hash
      end

      def create
        product = current_user.products.build(product_params)
        if product.save
          render json: ProductSerializer.new(product).serializable_hash, status: :created
        else
          render json: { errors: product.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @product.update(product_params)
          render json: ProductSerializer.new(@product).serializable_hash
        else
          render json: @product.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @product.destroy
        head :no_content
      end

      private

      def check_owner
        head :forbidden unless @product.user_id == current_user&.id
      end

      def product_params
        params.require(:product).permit(:price, :title, :published, :quantity)
      end

      def set_product
        @product = Product.find(params[:id])
      end
    end
  end
end
