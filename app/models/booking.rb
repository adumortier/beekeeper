class Booking < ApplicationRecord

  belongs_to :user
  has_many :booking_products, dependent: :destroy
  has_many :products, through: :booking_products

  validates_presence_of :comment, allow_blank: true

  enum status: %w(pending notified)

  def has_comment?
    return true unless (comment.nil? || comment == '')
  end
  
end