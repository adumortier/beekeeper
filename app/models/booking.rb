class Booking < ApplicationRecord

  belongs_to :user
  
  has_many :booking_products, dependent: :destroy
  has_many :products, through: :booking_products

  validates_presence_of :comment, allow_blank: true

  scope :user_bookings, ->(email) { joins(:user).where('email = ?', email) }

  def has_comment?
    comment.present?
  end

  def add_booking_products(products, params)
    products.each do |product|
      quantity = params[product.description + '_' + product.season]
      booking_products.create(product: product, quantity: quantity)
    end
  end

end