class Province < ApplicationRecord
    has_many :taxes
    has_many :customers
    validates :name, presence: true
end
