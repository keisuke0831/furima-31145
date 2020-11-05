class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :purchase
  belongs_to :category
  belongs_to :item_condition
  belongs_to :prefecture
  belongs_to :ship_date
  belongs_to :shipping_cost
  has_one_attached :image 

  with_options presence: true do
    validates :name
    validates :description
    validates :image
    validates :price   
    with_options numericality: { other_than: 1 }  do 
      validates :category_id
      validates :item_condition_id
      validates :prefecture_id
      validates :ship_date_id
      validates :shipping_cost_id
    end
    with_options numericality: {
      greater_than_or_equal_to: 300,
      less_than: 10000000  }  do
    validates :price
    end

  end
  
end
