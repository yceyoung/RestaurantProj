class RestaurantsController < ApplicationController
  # user login 
  #before_action :authenticate_user!

  # index
  def index
    @restaurants = Restaurant.page(params[:page]).per(20)
  end
end
