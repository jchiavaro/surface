class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :gender
  validates :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :gender, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save { |user| user.email = email.downcase }
  after_save :send_welcome_email
  has_secure_password

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
