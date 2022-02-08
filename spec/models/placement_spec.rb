# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Placement, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'functional' do
    let(:product) { create :product }
    let(:order) { build :order, user: product.user }

    it 'decreases the product quantity by the placement quantity' do
      init = product.quantity
      placement = described_class.create(order:, product:)
      expect(init - product.quantity).to eq(-placement.quantity)
    end
  end

  describe 'database: column specification' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(primary: true, null: false) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer).with_options(default: 0, null: false) }
    it { is_expected.to have_db_index(['order_id']) }
    it { is_expected.to have_db_column(:order_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_index(['product_id']) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer).with_options(null: false) }
  end
end
