class Product < ApplicationRecord

  validates_presence_of :description, :price, :season, :year

  belongs_to :booking, optional: true

  has_many :booking_products
  has_many :bookings, through: :booking_products, dependent: :destroy
end