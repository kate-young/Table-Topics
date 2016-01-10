class UserSessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are now logged in!"
      redirect_to table_topics_path 
    else
      logger.info params.inspect
      flash[:error] = "There was a problem logging in. Please check your email and password."
      render action: 'new'
    end
  end
  def destroy
    @current_user = nil
    session[:user_id] = nil
    flash[:success] = "You are now logged out"
    redirect_to login_path
  end
end
