class Booking < ApplicationRecord

  belongs_to :user
  has_many :booking_products
  has_many :products, through: :booking_products
end