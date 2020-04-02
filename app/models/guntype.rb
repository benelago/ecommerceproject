class Guntype < ApplicationRecord
    has_many :products
    validates :gunshottype, presence: true
end
