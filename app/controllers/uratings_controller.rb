class UratingsController < ApplicationController
    before_action :authenticate_user!
def new
  @transaction = Transaction.find(params[:transaction_id])
  @user = User.find(@transaction.user_id)
  @urating = Urating.new
  end

   def new_borrower
     @transaction = Transaction.find(params[:transaction_id])
     @user = User.find(@transaction.user_id)
     @urating = Urating.new
   end

   def new_lender_rating
     @transaction = Transaction.find(params[:transaction_id])
     @item = Item.find(@transaction.item_id)
     @user = User.find(@item.user_id)
     @urating = Urating.new
   end

  def index
  @transaction = Transaction.find(params[:transaction_id])
  @user = User.find(@transaction.user_id)
  @average = @user.uratings.average(:score) || "N/a"
  end

  def index_user
    @user = current_user
  end


 def create

    @transaction = Transaction.find(params[:transaction_id])
	  @user = User.find(@transaction.user_id)
    @urating = @user.uratings.create(urating_params)
    @urating.commenter = current_user

     if @urating.save
	        flash[:notice] = "Thank you for your feedback"
 			redirect_to transaction_uratings_path
     else
            flash[:error] = @urating.errors.full_messages
            render 'new'
	end

 end

 def create_lender_rating
   @transaction = Transaction.find(params[:transaction_id])
   @item = Item.find(@transaction.item_id)
   @user = User.find(@item.user_id)
   @urating = @user.uratings.create(urating_params)
   @urating.commenter = current_user

    if @urating.save
        flash[:notice] = "Thank you for your feedback"
      redirect_to history_index_items_path
    else
           flash[:error] = @urating.errors.full_messages
           render 'new'
    end
  end

  def create_borrower_rating
    @transaction = Transaction.find(params[:transaction_id])
	  @user = User.find(@transaction.user_id)
    @urating = @user.uratings.create(urating_params)
    @urating.commenter = current_user

     if @urating.save
	        flash[:notice] = "Thank you for your feedback"
 			redirect_to transaction_uratings_path
     else
            flash[:error] = @urating.errors.full_messages
            render 'new'
	end
   end

 def show

	@transaction = Transaction.find(params[:transaction_id])
	@user = User.find(@transaction.user_id)

 end


  def edit

	@urating = Urating.find(params[:id])
    if  @urating.commenter == current_user

    else
    flash[:error] = "You have no right to do this"
	redirect_to transaction_uratings_path
    end
  end

  def update

 	@urating = Urating.find(params[:id])
    if @urating.update(urating_params)
	  redirect_to transaction_uratings_path

    else
	  flash[:error] = "Update failed"
      render 'edit'
    end
  end

  def destroy

	@urating = Urating.find(params[:id])
	if @urating.commenter == current_user
    @urating.destroy
	redirect_to transaction_uratings_path
    else
    flash[:error] = "You have no right to do this"
	redirect_to transaction_uratings_path
    end

  end


   private
    def urating_params
      params.require(:urating).permit(:score, :comment)
    end

end
