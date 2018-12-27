class FriendsController < ApplicationController
before_action :authenticate_user!

def new
    @friend = Friend.new
    arr = current_user.friends.select(:target_id).to_a.map{|row| row.target_id}
    @targets = User.all.where.not(id:arr)
    # byebug
  end

  def index
  
  end

  def create
    @targets = User.all
    @user = current_user
    @friend = @user.friends.create(friend_params)
    
     
     if @friend.save
	  flash[:success] = "add friend successful"
 	  redirect_to friends_path
          
   else
      flash[:error] = "action failed"
      render 'new'
  end
  end

def show
@friend = Friend.find(params[:id])
@friend_obj = User.find(@friend.target_id)
@average = @friend_obj.uratings.average(:score) || "N/a"
end

def destroy
    @user = current_user
    @friend = @user.friends.find(params[:id])
	if  @friend.destroy
  flash[:success] = "unfriend successful"
	redirect_to friends_path
    else
    flash[:error] = "You have no right to do this"
	redirect_to friends_path
    end
    
  end
  
  private
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :target_id)
    end


end
