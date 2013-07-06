class ContactsList < ActiveRecord::Base
  has_many :contact, :dependent => :destroy
  belongs_to :user
  attr_accessible :description, :name
  validates :name, :user, presence: true
end
