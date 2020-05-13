FactoryBot.define do
  factory :card do
    user            { create(:user) }
    customer_id     {"cus_11111111111111aaaaaaaaaaaaaa"}
    card_id         {"car_11111111111111aaaaaaaaaaaaaa"}
  end
end