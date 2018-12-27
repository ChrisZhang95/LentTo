class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :target, foreign_key: "target_id", class_name: "User"
  validates :target_id, presence: true
end
