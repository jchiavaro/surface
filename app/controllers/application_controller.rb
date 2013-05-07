class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate_user
    unless session[:user_id]
      redirect_to root_path
      return false
    else
      @user = User.find session[:user_id]
      return true
    end
  end

  def save_login_state
    if session[:user_id]
      @user = User.find session[:user_id]
      redirect_to dashboard_user_path  @user
      return false
    else
      return true
    end
  end
end
