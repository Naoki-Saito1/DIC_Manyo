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
      # redirect_to user_path(@user.id)
      session[:user_id] = @user.id
      redirect_to tasks_path
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    # if params[:id] == current_user.id
    #    redirect_to user_path
    #   else
    #   redirect_to tasks_path
    # end
  end
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmarion)
    
  end
end
