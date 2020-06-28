FactoryBot.define do

  factory :address do
    first_name            {"太郎"}
    last_name             {"保外"}
    first_name_kana       {"タロウ"}
    last_name_kana        {"ホゲ"}
    postal_code           {"123-4567"}
    prefectures           {1}
    municipalities        {"横浜市緑区"}
    street_number         {"青山1-1-1"}
    detail_building       {"マンション"}
    telephone_number      {"09012345678"}
  end

end