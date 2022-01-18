require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'have attributes' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password_digest) }
  end

  describe 'association' do
    it { is_expected.to have_many(:orders).dependent(:destroy)}
    it { is_expected.to have_many(:products).dependent(:destroy)}
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to be_valid }
  end
end
