FactoryBot.define do
  factory :purchase_customer do
    postal_code { '123-4567' } 
    prefecture_id{ 2 } 
    city{ '神奈川県' } 
    address{ '1-1' } 
    phone_number{ '09098765432' } 
    token {"tok_abcdefghijk00000000000000000"}
  end
end