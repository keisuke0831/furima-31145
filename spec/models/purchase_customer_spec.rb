require 'rails_helper'

RSpec.describe PurchaseCustomer, type: :model do
    before do
      @purchase_customer = FactoryBot.build(:purchase_customer)
    end
  describe '購入情報の保存' do
    context '購入情報の保存ができる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_customer).to be_valid
      end
      it '建物の名前は空でも保存できること' do
        @purchase_customer.building_name = nil
        expect(@purchase_customer).to be_valid
      end
    end
    context '購入情報の保存ができない場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_customer.postal_code = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号がハイフンを含む必要があること' do
        @purchase_customer.postal_code = 1234567
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県の情報を選択していないと保存できないこと' do
        @purchase_customer.prefecture_id = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県の情報のidが1では保存出来ないこと' do
        @purchase_customer.prefecture_id = 1
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村が空だと保存できないこと' do
        @purchase_customer.city = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @purchase_customer.address = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Address can't be blank")
      end
      
      it '電話番号が空だと保存できないこと' do
        @purchase_customer.phone_number = ''
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が11桁以内の半角数字(ハイフンなし)でないと保存できないこと' do
        @purchase_customer.phone_number = 111111111111
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @purchase_customer.token = nil
        @purchase_customer.valid?
        expect(@purchase_customer.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
