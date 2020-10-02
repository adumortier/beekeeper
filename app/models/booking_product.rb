class BookingProduct < ApplicationRecord

  validates_presence_of :quantity

  belongs_to :booking
  belongs_to :product

end