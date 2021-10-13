class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]
  # before_action :admin_user
  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)
   if @user.save
    session[:user_id] = user.id
    redirect_to admin_user_path, notice: "登録しました"
   end
  end

  def index
    @users = User.all.order("created_at DESC")
  end

private
  # def admin_user
  #   redirect_to(root_path) unless current_user.admin?
  #   end
  # end

  def set_user
    @user = User.find(params[:id])
  end

  def set_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation )
  end
end