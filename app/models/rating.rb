class Rating < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :score, presence: true
  
end
