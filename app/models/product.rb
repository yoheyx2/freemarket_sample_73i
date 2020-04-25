class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :infomation, presence: true, length: { maximum: 1000 }
  validates :brand, presence: true

  has_many :product_images

  accepts_nested_attributes_for :product_images

  mount_uploader :image, ImageUploader
end
