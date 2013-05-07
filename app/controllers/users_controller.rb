class UsersController < ApplicationController

  before_filter :authenticate_user, :only => [:dashboard]
  before_filter :save_login_state, :only => [:create]

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "#{@user.first_name} was successfully created."
      redirect_to dashboard_user_path @user
    else
      flash[:error] = "Error creating user: See the messages below"
      render "home/index"
    end
  end

  def dashboard
    @user = User.find(params[:id])
  end
end
