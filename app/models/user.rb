class User < ActiveRecord::Base
  belongs_to :order
  
  validates :name, presence: true
  validates :address1, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :cc_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates_length_of :cc_number, :minimum => 16, :maximum => 16, :allow_blank => false
end