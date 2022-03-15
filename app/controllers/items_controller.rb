class ItemsController < ApplicationController
  before_action :move_to_index, only: [:new, :edit, :destroy]
  before_action :item_find, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root_path, only: [:edit, :destroy]
  

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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
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
    redirect_to root_path if current_user.id != @item.user_id
  end

  def item_find
    @item = Item.find(params[:id])
  end
end
