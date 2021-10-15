class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :user_name,presence: true, length: {maximum: 20}
  validates :email, presence: true, length: {maximum: 50},
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: {minimum: 6}
  before_update :update_action
  before_destroy :destroy_action

  private

  def destroy_action
    if User.where(admin:true).count == 1 && self.admin
      errors.add :users, "管理者がいなくなってしまいます"
      throw :abort
    end
  end

  def update_action
    @admin_users = User.where(admin: true)
      if @admin_users.count == 1 && self.admin == false && self == User.find_by(admin: true)
        errors.add :users, "管理者がいなくなってしまいます"
        throw :abort
      end
  end

end