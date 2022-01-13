class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password_digest, presence: true
end
