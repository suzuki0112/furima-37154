FactoryBot.define do
  factory :order_ship do
    token {"tok_abcdefghijk00000000000000000"}
    zip { '123-4567' }
    area_id { 2 }
    city { '東京都' }
    street { '1-1' }
    building { '東京ハイツ' }
    phone { 12345678910 }
  end
end
