class SessionsController < ApplicationController

  def login_attempt
    username_or_email = params[:username_or_email]
    password =  params[:password]

    #how to access the valid_mail_regex in user model
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    user_found = if email_regex.match(username_or_email)
      User.find_by_email(username_or_email)
    else
      # when we manage the user name selection we will be able use search by username
      # User.find_by_username(username_or_email)
    end

    if user_found
      authorized_user = user_found.authenticate(password)
    end
    
    if authorized_user
      session[:user_id] = authorized_user.id
      @user = User.find session[:user_id]
      flash[:notice] = "Welcome again, you logged in as #{authorized_user.first_name + ' ' + authorized_user.last_name  }"
      redirect_to user_dashboard_path @user
    else
      flash[:error] = "Invalid email or Password"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
