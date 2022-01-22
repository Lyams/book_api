require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:order)}
    it { is_expected.to belong_to(:product).inverse_of(:placements)}
  end
  describe "functional" do
    let(:product){ create :product}
    let(:order){build :order, user: product.user}
    it "decreases the product quantity by the placement quantity" do
      init = product.quantity
      placement = Placement.create(order: order, product: product)
      expect(init - product.quantity ).to eq(- placement.quantity)
    end
  end
end
