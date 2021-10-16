class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def index
    @users = User.all.order("created_at desc").page(params[:page]).per(10)
    if current_user.admin == false
        redirect_to tasks_path
    end
  end
  def new
    @user = User.new
    if current_user.admin == false
      redirect_to tasks_path, notice: "権限がありません"
  end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path 

    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.includes(:user).page(params[:page]).per(7)
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to admin_users_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # if User.all.where(admin: true).count == 1 && User.all.where(admin: false).count > 1
      @user.destroy
      redirect_to admin_users_path, notice: "削除しました"
  end

  private
  def user_params
      params.require(:user).permit(:user_name, :email, :admin, :password, :password_confirmation)
  end
end  
