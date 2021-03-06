class PurchaseCustomer
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :purchases_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :token
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{1,11}\z/ }
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1 }
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Customer.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchases_id: purchase.id)
  end
end
