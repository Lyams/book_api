require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: "example@example.com", password_digest: "00000") }

  describe 'have attributes' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:password_digest) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to be_valid }
  end
end
