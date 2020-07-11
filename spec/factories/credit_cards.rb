FactoryBot.define do
  factory :credit_card do
    customer_id { "abcdefghijklmnop" }
    card_id     { "abcdefghijklmnop" }
    user
  end
end