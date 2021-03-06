class Admin::RestaurantsController < Admin::BaseController
  # user login 
  before_action :authenticate_user!
  # self define admin action
  before_action :authenticate_admin

  before_action :set_restaurant, only:  [:show, :edit, :update, :destroy]

  def index
    #@restaurants = Restaurant.all
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  def show
    #@restaurant = Restaurant.find(params[:id])
  end

  def edit
    #@restaurant = Restaurant.find(params[:id])
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant was successfully updated"
      redirect_to admin_restaurant_path(@restaurant)
    else
      flash.now[:alert] = "restaurant was failed to update"
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to admin_restaurants_path
    flash[:alert] = "restaurant was deleted"
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:category_id, :name, :opening_hours, :tel, :address, :description, :image)
  end
end
