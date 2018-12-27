class Announcement < ApplicationRecord

    has_one_attached :image

    validates :title, presence: true
    validates :caption, presence: true
    validates :description, presence: true
    validates :image, presence: true
    validates :category, presence: true


    # Enum
    NOTICE = 1
    IMPORTANT = 2
    MAINTENANCE = 3
    STATUS = 4

    NOTICE_CATEGORIES = {
        NOTICE => 'Notice',
        IMPORTANT => 'Important',
        MAINTENANCE => 'Maintenance',
        STATUS => 'Status'
    }

    #Helper method for getting the data
    def category_name
        NOTICE_CATEGORIES[category]
    end
end
