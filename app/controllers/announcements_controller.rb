class AnnouncementsController < ApplicationController
    
    #temporarily disabled
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]

    def new
        @announcement = Announcement.new
    end

    def index
        @announcement = Announcement.all.order(updated_at: :desc)
        @announcement_notice = Announcement.where("category = 1").order(updated_at: :desc)
        @announcement_important = Announcement.where("category = 2").order(updated_at: :desc)
        @announcement_maintenance = Announcement.where("category = 3").order(updated_at: :desc)
        @announcement_status = Announcement.where("category = 4").order(updated_at: :desc)
    end

    def create
        @user_id = current_user
        @announcement = Announcement.new(announcement_params)
        
        if @announcement.save
            redirect_to action: "index"     
        else
            flash[:error] = @announcement.errors.full_messages
            render 'new'
        end
    end

    # Note: this should be called from a "Request an Extension" feature
    # Adding this for reference 
    def edit 
        @announcement = Announcement.find(params[:id])
    end

    def show
        @announcement = Announcement.all.order(updated_at: :desc)
        @announcement_details = Announcement.find(params[:id])
    end

    def update
        @announcement = Announcement.find(params[:id])

        if @announcement.update(announcement_params)
            redirect_to action: "index"
        else
            render 'edit'
        end
    end

    def destroy
        @announcement = Announcement.find(params[:id])
        @announcement.destroy

        redirect_to announcements_path
    end

    private
        def announcement_params
            params.require(:announcement).permit(:title, :caption, :category, :description, :image) 
        end
end

