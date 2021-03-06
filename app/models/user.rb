# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true, 'valid_email_2/email': { disposable: true }
  # validates_format_of :email, with: /@/
  validates :password_digest, presence: true

  has_secure_password
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
end
