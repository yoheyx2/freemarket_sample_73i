FactoryBot.define do
  factory :product_image do
    image {File.open("#{Rails.root}/public/test_image.jpg")}
    id         {"1"}
    product_id    {"1"}
    created_at {"2020/01/01"}
  end
end