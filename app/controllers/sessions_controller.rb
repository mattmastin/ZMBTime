class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email].downcase, params[:password])
    if user
      session[:user_id] = user.id
      if user.admin
        redirect_to admin_homes_url, :notice => "Logged in!"
      else
        redirect_to employee_homes_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
