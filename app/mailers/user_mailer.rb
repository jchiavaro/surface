class UserMailer < ActionMailer::Base
  default from: "notifications@surface.com"

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Surface!")
  end
end
