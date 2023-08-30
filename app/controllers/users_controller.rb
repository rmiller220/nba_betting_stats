class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id 
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password_digest)
    end
end
