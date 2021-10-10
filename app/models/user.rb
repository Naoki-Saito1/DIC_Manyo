class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :user_name,presence: true, length: {maximum: 20}
  validates :email, presence: true, length: {maximum: 50},
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: {minimum: 6}
end