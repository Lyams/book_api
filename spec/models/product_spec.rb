require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create :product }
  describe 'have attributes' do
    it { is_expected.to respond_to :price }
    it { is_expected.to respond_to :published }
    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :quantity }
  end

  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:placements).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:placements) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to be_valid }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe 'database: column specification' do
    it { should have_db_column(:id).of_type(:integer).with_options(primary: true, null: false) }
    it { should have_db_column(:quantity).of_type(:integer).with_options(default: 0, null: false) }
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:price).of_type(:decimal).with_options(default: 0.0, null: false) }
    it { should have_db_column(:published).of_type(:boolean).with_options(default: false, null: false) }
    it { should have_db_index(["user_id"]) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end
end
