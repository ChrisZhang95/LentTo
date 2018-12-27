class RatingsController < ApplicationController
  before_action :authenticate_user!
  
 def new
  @item = Item.find(params[:item_id])
  @rating = Rating.new
  end
  
  def index
  @item = Item.find(params[:item_id])
  @average = @item.ratings.average(:score)
  end

   
  

 def create
   
    @item = Item.find(params[:item_id])
    @rating = @item.ratings.create(rating_params)
	@rating.user = current_user
     if @rating.save
	        flash[:notice] = "Thank you for your feedback"
 			redirect_to item_ratings_path
     else
            flash[:error] = @rating.errors.full_messages
            render 'new'
	end
  
 end

 def show
  @item = Item.find(params[:item_id])
  @rating = @item.ratings.find(params[:id])
 end
 
 
  def edit
    @rating = Rating.find(params[:id])
	if @rating.user == current_user
    
    else
    flash[:error] = "You have no right to do this"
	redirect_to item_ratings_path
    end
  end
  
  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to item_ratings_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @item = Item.find(params[:item_id])
    @rating = @item.ratings.find(params[:id])
	if @rating.user == current_user
    @rating.destroy
	redirect_to item_ratings_path(@item)
    else
    flash[:error] = "You have no right to do this"
	redirect_to item_ratings_path
    end
    
  end
  
  
   private
    def rating_params
      params.require(:rating).permit(:score, :comment)
    end
	
end
