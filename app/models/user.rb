class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :addresses
         accepts_nested_attributes_for :addresses
         validates :nickname, presence: true
         validates :email, presence: true
         validates :password, presence: true, length: {minimum: 7}
         validates :password_confirmation, presence: true, length: {minimum: 7}
         validates :first_name, presence: true
         validates :last_name, presence: true
         validates :first_name_furigana, presence: true
         validates :last_name_furigana, presence: true
         validates :date_of_birth, presence: true
end