class Tax < ApplicationRecord
  belongs_to :province
  validates :name, :tax, presence: true
end
