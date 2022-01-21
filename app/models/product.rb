class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :orders, through: :placements

  scope :filter_by_title, lambda {|keyword|
    where('lower(title) LIKE ?', "%#{keyword.downcase}%")
  }
  scope :above_or_equal_to_price, lambda { |price|
    where('price >= ?', price)
  }
  scope :below_or_equal_to_price, lambda { |price|
    where('price <= ?', price)
  }
  scope :recent, lambda {
    order(:updated_at)
  }

  def self.search(params={})
    products = params[:product_ids].present? ? Product.where(id: params[:product_ids]) : Product.all
    products = Product.filter_by_title(params[:keyword]) if params[:keyword]
    products = Product.above_or_equal_to_price(params[:min_price]) if params[:min_price]
    products = Product.below_or_equal_to_price(params[:max_price]) if params[:max_price]
    products = products.recent if params[:recent]
    products
  end
end
