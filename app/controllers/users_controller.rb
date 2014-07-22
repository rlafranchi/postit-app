class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :require_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "User created"
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @user.update(user_params)
      flash[:notice] = "Profile update"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end