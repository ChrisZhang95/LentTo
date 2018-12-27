module Api
  class RatingsController < ApplicationController
    def index
      ratings = Rating.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded ratings', data:ratings},status: :ok
    end

    def show
      begin
        rating = Rating.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded rating', data:rating},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end
end
