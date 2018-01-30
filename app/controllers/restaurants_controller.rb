class RestaurantsController < ApplicationController
 
  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new
  end

  # GET restaurants/feeds
  # 會去 render app/views/restuarants/feeds.html.erb
  def feeds
    @recent_restaurants = Restaurant.all.order(created_at: :desc).limit(10)
    @recent_comments = Comment.all.order(created_at: :desc).limit(10)
  end
  
  def dashboard
    @restaurant = Restaurant.find(params[:id])
  end
  
  # POST /restaurants/:id/favorite
  def favorite
    @restaurant = Restaurant.find(params[:id])
    @restaurant.favorites.create!(user: current_user)
    
    redirect_back(fallback_location: root_path)  # 導回上一頁
  end
  
  # POST /restaurants/:id/unfavorite
  def unfavorite
    @restaurant = Restaurant.find(params[:id])
    
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    
    redirect_back(fallback_location: root_path)
  end
  
  # GET /restaurants/ranking
  def ranking
    @restaurants = Restaurant.order(favorites_count: :desc).limit(10)
  end
end
