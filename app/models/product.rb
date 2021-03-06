class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 40 }
  validates :infomation, presence: true, length: { maximum: 1000 }

  has_many :product_images
  belongs_to :category, optional: true
  belongs_to :user
  accepts_nested_attributes_for :product_images, allow_destroy: true
  validates_associated :product_images
  validates :product_images, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery
  belongs_to_active_hash :day
  belongs_to_active_hash :area
end