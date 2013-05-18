class UsersController < ApplicationController
  include SessionsHelper

  def sub_layout
    "board"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:notice] = "#{@user.first_name} was successfully created."
      redirect_to dashboard_user_path @user
    else
      flash[:error] = "Error creating user: See the messages below"
      render "home/index"
    end
  end

  def dashboard
    @user = User.find(params[:id])
    redirect_to root_path if !signed_in?
  end

  def confirm_account
    @user = User.where({auth_code: params[:auth_code]}).first
    if @user && !@user.expired?
      @user.update_attribute(:active, true)
      sign_in @user
      redirect_to dashboard_user_path @user
    else
      redirect_to root_path
    end
  end
end
