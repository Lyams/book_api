require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create :product}
  describe 'have attributes' do
    it {is_expected.to respond_to :price}
    it {is_expected.to respond_to :published}
    it {is_expected.to respond_to :title}
  end

  describe 'association' do
    it { is_expected.to belong_to(:user)}
    it { is_expected.to have_many(:placements).dependent(:destroy) }
    it { is_expected.to have_many(:orders).through(:placements) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to be_valid }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
