class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    if logged_in?
      redirect_to tasks_path
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end
  def show
    # @tasks = @user.tasks.includes(:user).page(params[:page]).per(5)
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to tasks_path,notice: "あなたのページではありません"
    end
  end
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
