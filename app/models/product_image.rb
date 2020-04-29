class ProductImage < ApplicationRecord
  belongs_to :product, optional: true
  mount_uploader :image, ImageUploader
end
