class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login Successful"
      redirect_to :tasks
    else
      flash.alert = "Login failed"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out, Goodbye"
    redirect_to root_path
  end
end
