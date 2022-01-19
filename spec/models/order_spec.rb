require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) {create :order}

  describe 'have attributes' do
    it {is_expected.to respond_to :total}
  end

  describe 'validation' do
  # it { is_expected.to validate_presence_of(:total)}
  # it { is_expected.to validate_numericality_of(:total).is_greater_than_or_equal_to(0) }
    it "fabrica" do
      expect(order).to be_valid
    end
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:placements).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:placements) }
  end

  context "Should set total" do
    let(:product){build :product}
    let(:product_keda){build :product_keda}
    it "" do
      order1 = Order.new(user: order.user)
      order1.products.push(product, product_keda)
      order1.save
      expect(order1.total).to eq (product.price + product_keda.price)
    end
  end
end
