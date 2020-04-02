class Quality < ApplicationRecord
    has_many :products
    validates :qualityGrade, presence: true
end
