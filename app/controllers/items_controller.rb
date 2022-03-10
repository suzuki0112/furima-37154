class ItemsController < ApplicationController
  before_action :move_to_index, only: [:new, :edit]
  before_action :move_to_root_path, only: [:edit]

  def index
    @items = Item.order('created_at DESC')
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
  def show
    @item = Item.find(params[:id])
  end
  def edit
    @item = Item.find(params[:id])
  end
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :freight_id, :area_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    authenticate_user!
  end
 
  def move_to_root_path
    @item = Item.find(params[:id])
    if current_user.id != @item.user_id
      redirect_to root_path
    end 
  end
end
