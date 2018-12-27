class ItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @item = Item.new
    @user = user_session[:id]
  end

  def index
    @items = Item.where(:user_id => current_user).paginate(:page => params[:page],:per_page => 10)
    @user = current_user
  end

  def create
    @action = "create"
    @item = Item.new(item_params)
    @item.user = current_user
      if @item.save
      flash[:success] = "Your item has been created"
 			redirect_to @item
       # @items = Item.all
       # render 'index'
	else
      flash[:error] = @item.errors.full_messages
      render 'new'
		end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @action = "edit"
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end


  def destroy
    @item = Item.find(params[:id])
   @item.destroy

    redirect_to items_path

    end

  # Function that deletes item's picture
  def delete_image_attachment
      @image = ActiveStorage::Attachment.find(params[:id])
      @image.purge
      redirect_back(fallback_location: items_path)
  end

  def gett_image_attachment
      redirect_back(fallback_location: items_path)
  end

  def borrowed_index
      @transactions = Transaction.where(:user => current_user)
      @borrowed_trans = @transactions.where(:status => Transaction::IN_PROGRESS).paginate(:page => params[:page],:per_page => 10)
      @borrowing_trans = @transactions.where(:status => Transaction::PENDING).paginate(:page => params[:page],:per_page => 10)
      @accepted_trans = @transactions.where(:status => Transaction::ACCEPTED).paginate(:page => params[:page],:per_page => 10)
      @rejected_trans = @transactions.where(:status => Transaction::REJECTED).order(id: :asc).limit(5).paginate(:page => params[:page],:per_page => 10)
  end

  def lent_index
      items = Item.where(:user => current_user)
      @lent_trans = Transaction.where(:item_id => items, :status => Transaction::IN_PROGRESS).paginate(:page => params[:page],:per_page => 10)
      @lending_trans = Transaction.where(:item_id => items, :status => Transaction::PENDING).paginate(:page => params[:page],:per_page => 10)
      @accepted_trans = Transaction.where(:item_id => items, :status => Transaction::ACCEPTED).paginate(:page => params[:page],:per_page => 10)
      @rejected_trans = Transaction.where(:item_id => items, :status => Transaction::REJECTED).order(id: :asc).limit(5).paginate(:page => params[:page],:per_page => 10)
  end

  def history_index
    # borrowed items
    @transactions = Transaction.where(:user => current_user)
    @borrowed_trans = @transactions.where(:status => Transaction::COMPLETED).paginate(:page => params[:page],:per_page => 10)

    # lent items
    items = Item.where(:user => current_user)
    @lent_trans = Transaction.where(:item_id => items, :status => Transaction::COMPLETED).paginate(:page => params[:page],:per_page => 10)
  end

  def qrcode
    @item = Item.find(params[:id])
    @name = @item.name.to_s
    @id = @item.id.to_s
  end

  def delete_all
    Item.destroy_all
  end
  private
    def item_params
      params.require(:item).permit(:name, :category_id, user_session[:id], :description, :public, :location, images:[])
    end
end
