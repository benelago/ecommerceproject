class Product < ApplicationRecord
  paginates_per 10
  belongs_to :guntype
  belongs_to :quality
  has_many :details
  has_many :orders, through: :details
  has_one_attached :product_image
  validates :name, :description, :price, presence: true
end
