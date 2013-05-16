module SessionsHelper
  def sign_in user
    session[:user_id] = user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) unless session[:user_id].nil?
  end

  def signed_in?
    !current_user.nil?
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end
end
