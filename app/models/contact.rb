class Contact < ActiveRecord::Base
  belongs_to :contacts_list
  attr_accessible :comments, :email, :first_name, :last_name
  validates :first_name, :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  before_save { |user| user.email = email.downcase }
end
