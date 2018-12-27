class TransactionsController < ApplicationController
    before_action :authenticate_user!

    def new
        @transaction = Transaction.new
        @user_id = current_user.id
    end

    def index
        @transaction = Transaction.all
    end

    def create
        @user_id = current_user
        @transaction = Transaction.new(transaction_params)
        @transaction.user = current_user

        if @transaction.save
            redirect_to action: "index"
        else
            flash[:error] = @transaction.errors.full_messages
            render 'new'
        end
    end

    # Note: this should be called from a "Request an Extension" feature
    # Adding this for reference
    def edit
        @user_id = current_user.id
        @transaction = Transaction.find(params[:id])
    end

    def show
        @transaction = Transaction.find(params[:id])
    end

    def update
        @transaction = Transaction.find(params[:id])

        if @transaction.update(transaction_params)
            redirect_to action: "index"
        else
            render 'edit'
        end
    end

    def destroy
        @transaction = Transaction.find(params[:id])
        @transaction.destroy

        redirect_to transactions_path
    end

    def request_accept
      @transaction = Transaction.find(params[:id])
      @transaction.status = Transaction::ACCEPTED
      @transaction.save

      redirect_back(fallback_location: lent_index_items_path)
    end

    def request_reject
      @transaction = Transaction.find(params[:id])
      @transaction.status = Transaction::REJECTED
      @transaction.save

      redirect_back(fallback_location: lent_index_items_path)
    end

    def request_cancel
      @transaction = Transaction.find(params[:id])
      @transaction.status = Transaction::CANCELLED
      @transaction.save

      redirect_back(fallback_location: borrowed_index_items_path)
    end

    def meetup_success
      @transaction = Transaction.find(params[:id])
      @transaction.status = Transaction::IN_PROGRESS
      @transaction.save
      redirect_back(fallback_location: borrowed_index_items_path)
    end

    def return_success
      @transaction = Transaction.find(params[:id])
      @transaction.status = Transaction::COMPLETED
      @transaction.end_date = DateTime.now()
      @transaction.save
      redirect_back(fallback_location: lent_index_items_path)
    end

    def create_meetup
        @user_id = current_user
        @transaction = Transaction.new(transaction_params)
        @transaction.user_id = current_user.id

        if @transaction.save
          redirect_back(fallback_location: items_path)
          flash[:success] = "Transaction successfuly went through"
        else
            flash[:error] = @transaction.errors.full_messages
            render 'new'
        end
    end

    def new_lender_rating
      @transaction = Transaction.find(params[:id])
      @item = Item.find(@transaction.item_id)
      @user = User.find(@item.user_id)
      @urating = Urating.new

    end

    private
        def transaction_params
            params.require(:transaction).permit(:item_id, :start_date, :end_date, :status)
        end
end
