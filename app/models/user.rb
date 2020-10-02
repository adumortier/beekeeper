# encoding: UTF-8
class User < ApplicationRecord

  validates_presence_of :first_name, :last_name
  validates :email, uniqueness: true, presence: true
  validates_confirmation_of :password, :message => "Passwords should match"
  validates :phone_number, telephone_number: {country: :FR, types: [:fixed_line, :mobile], message: "Votre numero de téléphone n'est pas valide"}

  has_many :bookings
  has_secure_password

  enum role: %w(default admin)
  
end