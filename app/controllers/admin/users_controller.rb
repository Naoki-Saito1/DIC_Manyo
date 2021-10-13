class Admin::UsersController < ApplicationController

  def index
    @users = User.all.order("created_at asc")

  end
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end
  def shew
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end
  private
  def user_params
      params.require(:user).permit(:user_name, :email, :admin, :password, :password_confirmation)
  end
end  
