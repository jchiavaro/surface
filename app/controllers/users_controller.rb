class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      mail = UserMailer.welcome_email(@user)
      mail.deliver
      redirect_to user_dashboard_path @user
    else
      redirect_to root_path
    end
  end

  def dashboard
    @user = User.find(params[:id])
  end
end
