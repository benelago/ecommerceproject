class Order < ApplicationRecord
  belongs_to :customer
  has_many :details
  has_many :products, through: :details
  validates :tax, :total, presence: true
end
