class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :my, :types

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def require_login
    if current_user
      true
    else
      redirect_to login_path, notice: "You must be logged in to access that page"
    end
  end
end
