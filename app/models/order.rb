class Order < ApplicationRecord
  before_validation :set_total!
  belongs_to :user
  validates :total, numericality:  { greater_than_or_equal_to: 0}, presence: true
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements
  def set_total!
    self.total = products.map(&:price).sum
  end
end
