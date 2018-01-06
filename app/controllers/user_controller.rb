class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants
  end
end
