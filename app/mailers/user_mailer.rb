class UserMailer < ActionMailer::Base
  default from: "surfacenotifications@surface.com"

  def welcome_email(user)
    @user = user
    @confirm_account_url  = "http://#{HOSTS_CONFIG["public"]}/users/#{@user.id}/account/#{@user.auth_code}"
    mail(to: @user.email, subject: "Welcome to Surface!")
  end
end
