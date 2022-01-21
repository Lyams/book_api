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

  context "" do
    let(:product){build :product}
    let(:product_keda){build :product_keda}
    it "Should set total" do
      order1 = Order.new(user: order.user)
      order1.products.push(product, product_keda)
      order1.save
      expect(order1.total).to eq (product.price + product_keda.price)
    end

    # it "builds 2 placements for the order" do
    #   order1 = Order.new(user: order.user)
    #   order1.build_placements_with_product_ids_and_quantities [
    #       { product_id: product.id, quantity: 2},
    #       { product_id: product_keda.id, quantity: 3},]
    #   expect{ order1.save }.to change { Placement.count }.by(2)
    # end
  end
end
