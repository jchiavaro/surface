class User < ActiveRecord::Base
  has_many :contacts_list, :dependent => :destroy
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :gender, :expires_at, :active
  validates :first_name, :last_name, :email, :password, :password_confirmation, :birthday, :gender, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, :last_name, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save :generate_auth_token, :set_expiration_date
  before_save { |user| user.email = email.downcase }
  after_save :send_welcome_email
  has_secure_password

  scope :actives, -> {where(active: true)}

  def expired?
    true if Time.now > expires_at
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  def generate_auth_token
    self.auth_code = SecureRandom.urlsafe_base64(32)
  end

  def set_expiration_date
    self.expires_at = Time.now + 2.days
  end
end
