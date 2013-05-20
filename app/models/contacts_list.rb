class ContactsList < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name
  validates :name, presence: true
end
