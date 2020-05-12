FactoryBot.define do
  factory :product do
    name            {Faker::Games::Zelda.item}
    infomation      {Faker::Games::Zelda.game}
    category_id     {"1"}
    brand           {Faker::Games::Zelda.location}
    status          {"1"}
    delivery_fee    {"1"}
    ship_form       {"1"}
    delivery_time   {"1"}
    price           {Faker::Number.number(digits: 4)}
    situation       {"1"}
    user
  end
end