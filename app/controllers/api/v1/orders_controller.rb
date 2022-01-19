class Api::V1::OrdersController < ApplicationController
  before_action :check_login

  def create
    order = current_user.orders.build(order_params)
    if order.save
      render json: order, status: :created # 201
    else
      render json: { errors: order.errors}, status: :unprocessable_entity # 422
    end
  end

  def index
    render json: OrderSerializer.new(current_user.orders).serializable_hash
  end

  def show
    order = current_user.orders.find(params[:id])
    if order
      options = { include: [:products] }
      render json: OrderSerializer.new(order, options).serializable_hash
    else
      head :not_found # 404
    end
  end

  private
  def order_params
    params.require(:order).permit(:total, product_ids: [])
  end
end
