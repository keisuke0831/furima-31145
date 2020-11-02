class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do

    validates :nickname,  length: { maximum: 40 }
    validates :birthday
    with_options format:{ with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須です' }  do
      validates :lastname 
      validates :first_name
    end 
    with_options format:{ with: /\A[ァ-ヶー－]+\z/, message: 'は全角（カタカナ）での入力が必須です' } do
    validates :last_name_kana
    validates :first_name_kana
    end
  end

  has_many :items
  has_many :purchases
end
