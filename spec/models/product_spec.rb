require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create :product}
  describe 'have attributes' do
    it {is_expected.to respond_to :price}
    it {is_expected.to respond_to :published}
    it {is_expected.to respond_to :title}
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to be_valid }
    it 'should have a positive price' do
      subject.price = -1
      expect(subject).not_to be_valid
    end
  end
end
