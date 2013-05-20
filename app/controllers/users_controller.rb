class UsersController < ApplicationController
  include SessionsHelper

  def sub_layout
    "board"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "#{@user.first_name} was successfully created."
      redirect_to confirmation_user_path @user
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
      #update_column will skip validations and callbacks
      @user.update_column(:active, true)
      sign_in @user
      redirect_to dashboard_user_path @user
    else
      redirect_to root_path
    end
  end
end
