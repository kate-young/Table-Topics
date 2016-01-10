module ApplicationHelper

  def signed_in
    session[:user_id] ? true : false
  end

  def auth_text 
    signed_in ? "Log Out" : "Log In"
  end

  def auth_link
    signed_in ? logout_path : login_path
  end

end
