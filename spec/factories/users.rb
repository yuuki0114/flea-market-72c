FactoryBot.define do

  factory :user do
    nickname              {"hoge"}
    email                 {"a123456@gmal.com"}
    password              {"a111111"}
    password_confirmation {"a111111"}
  end

end