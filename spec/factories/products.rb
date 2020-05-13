FactoryBot.define do
  factory :product do
    name            {Faker::Games::Zelda.item}
    infomation      {Faker::Games::Zelda.game}
    category_id     {"1"}
    brand           {Faker::Games::Zelda.location}
    status_id       {"1"}
    delivery_id     {"1"}
    area_id         {"1"}
    day_id          {"1"}
    price           {Faker::Number.number(digits: 4)}
    situation       {"1"}
    user
  end
end