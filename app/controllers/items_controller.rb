class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, except: [:index, :show]
  before_action :move_to_top, only: [:edit]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :item_condition_id, :prefecture_id, :ship_date_id, :shipping_cost_id, :image, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_top
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user.id
  end
end
