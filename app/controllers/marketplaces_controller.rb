class MarketplacesController < ApplicationController
    def index
        @friend = false
        #list all items in the transaction record
        @displayItems = Item.filter(params).friends(params).search(params).paginate(:page => params[:page], :per_page => 4)
        @displayItems = @displayItems.where(:public => 1)
        @user = current_user
        @friend = params[:friends]
        @f = Item.f(params)
        for node in @displayItems
            class << node
                attr_accessor :stars, :blank_stars, :average
            end
            ratingArr = []
            for rating in node.ratings
                ratingArr.push(rating.score)
            end
             if ratingArr.size > 0
                node.average = ratingArr.sum/ratingArr.size.to_f
                node.stars = node.average.to_i
            else
                node.average = 0
                node.stars = 0
            end
            node.blank_stars = (5 - node.stars).to_i
        end
        getMapItems
        get_select_items
    end
    def show
        #pass in the item id contained in the transaction record
        @item = Item.find_by(id: params[:id])
        @unavailable_times = Transaction.where("(status = ? OR status = ?) AND (item_id = ?)", Transaction::IN_PROGRESS, Transaction::ACCEPTED, @item.id).select(:start_date, :end_date)
        class << @item
            attr_accessor :stars, :blank_stars, :average
        end
        ratingArr = []
        for rating in @item.ratings
            ratingArr.push(rating.score)
        end
        if ratingArr.size > 0
            @item.average = ratingArr.sum/ratingArr.size.to_f
            @item.stars = @item.average.to_i
        else
            @item.average = 0
            @item.stars = 0
        end
        @item.blank_stars = (5 - @item.stars).to_i


    end
    def create
        #identify the params sent from frontend
        @marketplace_params = ActionController::Parameters.new({
            transaction: {
              user_id: current_user.id,
              item_id: params[:itemid],
              start_date: params[:start],
              end_date: params[:end],
              status: Transaction::PENDING
            }
          })
        print current_user
        #create a transaction once we know user wants to borrow
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
            @item = Item.find_by(id: params[:itemid])
            # newTransactionLogDetails = "Your item " + @item.name + " has been requested by " + current_user.profile.first_name + " " + current_user.profile.last_name + " between the dates of " + params[:start] + " and " + params[:end]
            # @log = Log.new({title: "New Request For item", details: newTransactionLogDetails, affected_user: @item.user_id, sendng_user: current_user.id, seen: false})
            # @log.save
            redirect_to marketplaces_url
        else
            flash[:error] = @transaction.errors.full_messages
            redirect_to marketplace_url(:action=>"show", :controller=>"marketplaces", id: params[:itemid])
        end
    end
    def getMapItems
        #@mapItems = Item.all.to_json.html_safe
        @mapItems = Item.all
        @img_list = {}
        for fullItem in @mapItems

            class << fullItem
                attr_accessor :img_url
            end

            fullItem.img_url = url_for(fullItem.images.first)
            @img_list[fullItem.id] = fullItem.img_url
        end
        @mapItems = @mapItems.to_json.html_safe
        @img_list = @img_list.to_json.html_safe
    end
    private
        def transaction_params
            @marketplace_params.require(:transaction).permit(:user_id, :item_id, :start_date, :end_date, :status)
        end

        def get_select_items
            @select_items = [["All", 0]]
            for i in Category.all.collect{|c| [c.name, c.id] }
                @select_items.push(i)
            end
        end
end
