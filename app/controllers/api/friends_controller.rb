module Api
  class FriendsController < ApplicationController
    def index
      friends = Friend.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded friends', data:friends},status: :ok
    end

    def show
      begin
        friend = Friend.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded friend', data:friend},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end
end
