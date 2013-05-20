class SessionsController < ApplicationController
  include SessionsHelper

  def login_attempt
    @user = User.actives.find_by_email(params[:user][:email].downcase)
    if @user && @user.authenticate(params[:user][:password])
      sign_in @user
      flash[:notice] = "Welcome again, you logged in as #{@user.first_name + ' ' + @user.last_name  }"
      redirect_to dashboard_user_path @user
    else
      flash[:error] = "Invalid Email/Password combination - Check your credentials and make sure you have confirmed the account"
      redirect_to root_path
    end
  end

  def logout
    sign_out
    redirect_to root_path
  end
end
