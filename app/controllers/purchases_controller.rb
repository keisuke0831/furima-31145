class PurchasesController < ApplicationController
  def index
    
    @item = Item.find(params[:item_id])
    @purchase_customer = PurchaseCustomer.new 
  end

  def create
    @item = Item.find(params[:item_id]) 
    @purchase_customer = PurchaseCustomer.new(purchase_params) 
    if @purchase_customer.valid?
      pay_item
      @purchase_customer.save
      redirect_to controller: :items, action: :index
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end   
     
  private
  def purchase_params
  params.require(:purchase_customer).permit( :postal_code, :prefecture_id, :city, :address, :building_name,:phone_number ,:purchases_id).merge( user_id: current_user.id, item_id: params[:item_id],token: params[:token] ) 
  end
  def pay_item
  @item = Item.find(params[:item_id]) 
  Payjp.api_key = "sk_test_8b099edfbb334ca77404ed6a" 
      Payjp::Charge.create(
        amount: @item.price,  
        card: purchase_params[:token],    
        currency: 'jpy'                 
      )
  end
end   