class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

     

  with_options presence: true do
    validates :nickname, length: { maximum: 40 }
    validates :birthday
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: 'は全角（漢字・ひらがな・カタカナ）での入力が必須です' } do
      validates :lastname
      validates :first_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角（カタカナ）での入力が必須です' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  has_many :items
  has_many :purchases
  has_many :sns_credentials  
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end  
end
