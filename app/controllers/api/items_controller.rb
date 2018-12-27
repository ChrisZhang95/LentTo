
module Api
  class ItemsController < ApplicationController

    def index
      items = Item.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded items', data:items},status: :ok
    end

    def show
      begin
        item = Item.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded item', data:item},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end


end
