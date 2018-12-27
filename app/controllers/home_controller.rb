class HomeController < ApplicationController
  
  before_action :first_visit_check

  MAX_ANNOUNCEMENTS = 5

  def index
    # Do nothing for now
  end

  def show
    @announcement = Announcement.all.order(updated_at: :desc).limit(MAX_ANNOUNCEMENTS)
    @announcement_notice = Announcement.where("category = 1").order(updated_at: :desc).limit(MAX_ANNOUNCEMENTS)
    @announcement_important = Announcement.where("category = 2").order(updated_at: :desc).limit(MAX_ANNOUNCEMENTS)
    @announcement_maintenance = Announcement.where("category = 3").order(updated_at: :desc).limit(MAX_ANNOUNCEMENTS)
    @announcement_status = Announcement.where("category = 4").order(updated_at: :desc).limit(MAX_ANNOUNCEMENTS)
  
    @num_of_items = Item.count + 3560
    @num_of_users = User.count + 100
    @num_of_transcations = Transaction.count + 123482
  end

  #check if it is a first time visit.
  def first_visit_check
    unless(cookies[:first_visit])
      cookies.permanent[:first_visit] = 1;
      redirect_to landing_path
    end
  end
end