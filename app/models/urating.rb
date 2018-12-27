class Urating < ApplicationRecord
  belongs_to :user
  belongs_to :commenter, foreign_key: "commenter_id", class_name: "User"
  #belongs_to :connection, foreign_key: "transaction_id", class_name: "Transaction"
  validates :score, presence: true

end
