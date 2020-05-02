FactoryBot.define do
  factory :product_image do
    image {File.open("#{Rails.root}/public/test_image.jpg")}
  end
end