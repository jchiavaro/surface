class UserMailer < ActionMailer::Base
  default from: "surfacenotifications@surface.com"

  def welcome_email(user)
    @user = user
    @url  = "http://#{HOSTS_CONFIG["public"]}"
    mail(to: user.email, subject: "Welcome to Surface!")
  end
end
