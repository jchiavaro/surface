class ContactsList < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name
  validates :name, :user, presence: true
end
