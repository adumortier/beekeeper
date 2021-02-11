# encoding: UTF-8
class User < ApplicationRecord

  include ActiveModel::Dirty

  validates_presence_of :first_name, :message => "Merci de renseigner votre prénom."
  validates_presence_of :last_name, :message => "Merci de renseigner votre nom."
  validates_presence_of :address, :message => "Votre addresse n'est pas valide."
  validates_presence_of :city, :message => "Merci de renseigner votre ville."
  validates_presence_of :zip_code, :message => "Merci de renseigner votre code postal."
  validates :email, uniqueness: true, presence: true
  validates_confirmation_of :password, :message => "Le mot de passe et la confirmation doivent être identiques."
  validates :phone_number, telephone_number: {country: :FR, types: [:fixed_line, :mobile], message: "Votre numéro de téléphone n'est pas valide"}

  has_many :bookings, dependent: :destroy
  has_many :posts
  
  has_secure_password

  enum role: %w(default admin)

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver
  end

  def send_booking_confirmation(booking)
    UserMailer.confirm_booking(self, booking).deliver
  end

  def send_change_confirmation(booking)
    UserMailer.confirm_booking_change(self, booking).deliver
  end

  def send_admin_booking_confirmation(booking)
    UserMailer.confirm_admin_booking(self, booking).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  
end