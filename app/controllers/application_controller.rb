class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success

  def current_user
    User.find(session[:user_id])
  end

end
