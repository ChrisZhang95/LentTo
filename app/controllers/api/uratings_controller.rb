module Api
  class UratingsController < ApplicationController
    def index
      uratings = Urating.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded uratings', data:uratings},status: :ok
    end

    def show
      begin
        urating = Urating.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded urating', data:urating},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end
end
