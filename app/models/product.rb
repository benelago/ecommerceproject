class Product < ApplicationRecord
  belongs_to :guntype
  belongs_to :quality
  has_many :details
  has_many :orders, through: :details
  validates :name, :description, :price, presence: true
end
