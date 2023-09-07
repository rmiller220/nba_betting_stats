class UsersController < ApplicationController
  def show
    if current_user
      @user = User.find(session[:user_id])
      if current_user.id == @user.id
        @user = User.find(session[:user_id])
      else
        flash[:error] = "Only the user can view their profile."
        redirect_to root_path
      end
    else
      flash[:error] = "Only the user can view their profile."
      redirect_to root_path
    end
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

  def login_user
      user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
