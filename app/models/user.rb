class User < ApplicationRecord
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates_format_of :email, :with => /^\S+@\S+\.\S+/
end
