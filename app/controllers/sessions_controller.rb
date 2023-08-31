class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to '/profile'
  end
end