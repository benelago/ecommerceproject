class Customer < ApplicationRecord
  belongs_to :province
  has_many :order
  validates :name, :address, :email, presence: true
end
