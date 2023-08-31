class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new 
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id 
      redirect_to profile_path(user)
    else
      flash[:error] = "Invalid credentials. Please try again."
      redirect_to new_user_path
    end
  end

  def login_form

  end

  def login
      user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
