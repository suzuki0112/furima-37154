class ItemsController < ApplicationController
   
  before_action :move_to_index, only: [:new]

  def index
  end
  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :freight_id, :area_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    authenticate_user!
  end
end
