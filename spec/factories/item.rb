FactoryBot.define do

  factory :item do
    name             {"イス"}
    detail           {"10年以上使用しました"}
    status           {"全体的に状態が悪い"}
    delivery_fee     {"着払い(購入者負担)"}
    start_address    {"沖縄"}
    shipping_date    {"4~7で発送"}
    price            {"3000"}
    category_id      {"1"}
  end

end