class Quality < ApplicationRecord
    has_many :products
    has_one_attached :quality_image
    validates :name, presence: true
end
