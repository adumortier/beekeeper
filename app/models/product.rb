# encoding: UTF-8
class Product < ApplicationRecord

  enum status: %w(active inactive)

  validates_presence_of :description, :price, :season, :year
  validates_numericality_of :year, on: :create
  
  validates :price, numericality: { greater_than_or_equal_to: 0.0 }
  
  validates :year, numericality: { only_integer: true, greater_than_or_equal_to: ->(_product) { Date.current.year }}

  belongs_to :booking, optional: true

  has_many :booking_products
  has_many :bookings, through: :booking_products, dependent: :destroy

  scope :current_year, -> { where(year: Time.new.year) }
  scope :spring, -> { where(season: 'printemps') }
  scope :summer, -> { where(season: 'été') }
  scope :active, -> { where(status: 'active').order(price: :asc) }

  def action
    status == 'active' ? 'désactiver' : 'activer'
  end

end