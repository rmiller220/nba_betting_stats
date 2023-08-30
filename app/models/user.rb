class User < ApplicationRecord
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true

  has_secure_password
end
