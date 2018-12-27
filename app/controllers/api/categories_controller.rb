module Api
  class CategoriesController < ApplicationController
    def index
      categories = Category.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded categories', data:categories},status: :ok
    end

    def show
      begin
        category = Category.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded category', data:category},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end
end
