FactoryBot.define do

  factory :sns_credential do
    provider     {"google_oauth2"}
    uid          {"111111111111111111111"}
  end

end