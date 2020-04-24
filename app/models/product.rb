class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :infomation, presence: true, length: { maximum: 1000 }
  validates :brand, presence: true
end
