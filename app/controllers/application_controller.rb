class ApplicationController < ActionController::Base
  before_filter :require_login
  skip_before_filter :require_login
  protect_from_forgery with: :exception
  add_flash_types :success

  def current_user
    User.find(session[:user_id])
  end

  def require_login
    unless session[:user_id] 
      redirect_to login_path
    end
  end

end
