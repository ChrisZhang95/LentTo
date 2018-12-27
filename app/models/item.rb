class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :transactions, dependent: :destroy
  has_many :ratings, dependent: :destroy

  #has_many :transactions

  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true
  validates :location, presence: true

  def self.search(params)
    items = Item.order("name")
    items = Item.where("name like ? OR description like ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search]
    items
  end

  def self.filter(params)
    items = Item.order("name")
    if params[:category_id] != nil && params[:category_id] != "0"
      items = Item.where(category_id: params[:category_id]) if params[:category_id]
      items
    else
      items
    end
  end

  def self.friends(params)
    items = Item.order("name")
    if params[:friends] != nil && params[:friends] == "true"
      @friends = Friend.where(:user_id => params[:current_user_id])
      @current_user = User.where(id: params[:current_user_id]).first
      target_ids = @current_user.friends.select(:target_id).to_a.map{|row| row.target_id}
      @items = Item.all.where(user: target_ids)
    else
      Item.all
    end
  end

  def self.f(params)
    params[:friends]
  end

  def average_rating
    _rating = self.ratings.average(:score)
    if _rating
      _rating.round(1)
    else
      "-"
    end
  end

  def rating_count(num)
    _condition = "score = " + num.to_s
    self.ratings.where(score: num).count
  end

  def rating_stars
    _rating = self.ratings.average(:score).to_i
  end

  def rating_blanks
    5 - self.rating_stars
  end

end
