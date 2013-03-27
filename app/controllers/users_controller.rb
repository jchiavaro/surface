class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      mail = UserMailer.welcome_email(@user)
      mail.deliver
      flash[:notice] = "#{@user.first_name} was successfully created."
      redirect_to user_dashboard_path @user
    else
      flash[:error] = "Error creating user"
      redirect_to root_path
    end
  end

  def dashboard
    @user = User.find(params[:id])
  end
end
