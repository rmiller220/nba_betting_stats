class UsersController < ApplicationController
  def show
    if current_user
      @user = User.find(session[:user_id])
      if current_user.id == @user.id
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

  def edit
    @user = User.find(params[:format])
    if current_user.id == @user.id
      # @user = User.find(session[:user_id])
    else
      flash[:error] = "Only the user can view their profile."
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:format])
    if current_user.id == @user.id
      require 'pry'; binding.pry
      if @user.update(user_params) #&& !@user.update(user_params)
        require 'pry'; binding.pry
        # @user.update(user_params)
        current_user.update(user_params_edit) && !current_user.update(user_params)
        # require 'pry'; binding.pry
        flash[:success] = "Your profile has been updated." 
        redirect_to profile_path(@user)
        # require 'pry'; binding.pry
        # render :show
      else
        flash[:error] = "Please fill in all fields."
        redirect_to edit_profile_path(@user)
      end
    else 
      flash[:error] = "Only the user can view their profile."
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
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private
    def user_params_edit
      params.permit(:username, :email)
    end
    # def user_params_edit
    #   require 'pry'; binding.pry
    #   params.require(:user).permit(:username, :email)
    # end
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
