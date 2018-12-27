class Log < ApplicationRecord
    validates :title, presence: true
    validates :seen, presence: true
    validates :affected_user, presence: true
end
