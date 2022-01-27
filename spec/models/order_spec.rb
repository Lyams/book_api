require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create :order }

  describe 'have attributes' do
    it { is_expected.to respond_to :total }
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

  describe 'database: column specification' do
    it { should have_db_column(:id).of_type(:integer).with_options(primary: true, null: false) }
    it { should have_db_column(:total).of_type(:decimal).with_options(null: false) }
    it { should have_db_index(["user_id"]) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  context "Calculate total" do
    let(:product) { create :product, user: order.user }
    let(:product_keda) { create :product_keda }
    it "Should set total" do
      order1 = Order.new(user: order.user)
      order1.placements = [Placement.new(product_id: product.id, quantity: 2),
                           Placement.new(product_id: product_keda.id, quantity: 1)]
      order1.set_total!
      expect(order1.total).to eq (product.price * 2 + product_keda.price * 1)
    end
    # it "an order should command not too much product than available" do
    #   order.placements << Placement.new(product_id: product.id, quantity: (1 + product.quantity))
    #   expect(order).not_to be_valid
    # end

    # it "builds 2 placements for the order" do
    #   order1 = Order.new(user: order.user)
    #   order1.build_placements_with_product_ids_and_quantities [
    #       { product_id: product.id, quantity: 2},
    #       { product_id: product_keda.id, quantity: 3},]
    #   expect{ order1.save }.to change { Placement.count }.by(2)
    # end
  end
end
