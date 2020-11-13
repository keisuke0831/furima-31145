class PurchasesController < ApplicationController
  before_action :move_to_index, only: [:create, :index]
  before_action :set_item, only: [:create, :index]
  before_action :move_to_top, only: [:create, :index]
  before_action :move_to_page, only: [:create, :index]

  def index
    @purchase_customer = PurchaseCustomer.new
  end

  def create
    @purchase_customer = PurchaseCustomer.new(purchase_params)
    if @purchase_customer.valid?
      pay_item
      @purchase_customer.save
      redirect_to controller: :items, action: :index
    else

      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_customer).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchases_id).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to controller: :items, action: :index unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_top
    redirect_to controller: :items, action: :index if user_signed_in? && current_user.id == @item.user.id
  end

  def move_to_page
    redirect_to controller: :items, action: :index if @item.purchase.present?
  end
end
