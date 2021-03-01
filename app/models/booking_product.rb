class BookingProduct < ApplicationRecord

  validates_presence_of :quantity, numericality: { only_integer: true, greater_than: 0}

  belongs_to :booking
  belongs_to :product

  enum status: %w(pending notified)

end