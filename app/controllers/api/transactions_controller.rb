module Api
  class TransactionsController < ApplicationController
    def index
      trans = Transaction.order('created_at ASC');
      render json: {status: 'SUCCESS', message:'Loaded transactions', data:trans},status: :ok
    end

    def show
      begin
        transaction = Transaction.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded transaction', data:transaction},status: :ok
      rescue
          render json: {status: 'FAILED', message:'Failed to find', data:"No record found with id: " + params[:id]},status: :failed
      end
    end
  end
end
