class Profile < ApplicationRecord
    belongs_to :user
    has_many :transactions
    has_one_attached :avatar
	
	def self.search(params)
        profiles = Profile.order("first_name")
        profiles = Profile.where("first_name like ?", "%#{params[:search]}%") if params[:search]
        profiles
    end

    def name
        if self.first_name && self.last_name && (!self.first_name.blank? || !self.last_name.blank?)
            self.first_name + " " + self.last_name
        else
            ""
        end
    end
	
end
