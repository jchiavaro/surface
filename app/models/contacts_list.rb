class ContactsList < ActiveRecord::Base
  has_many :contact
  belongs_to :user
  attr_accessible :description, :name
  validates :name, :user, presence: true
end
