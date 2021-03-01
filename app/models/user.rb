# encoding: UTF-8
class User < ApplicationRecord

  include ActiveModel::Dirty

  validates_presence_of :first_name, message: 'prénom'
  validates_presence_of :last_name, message: 'nom'
  validates_presence_of :address, message: 'adresse'
  validates_presence_of :city, message: 'ville'
  validates_presence_of :zip_code, message: 'code postal'
  validates_presence_of :email, message: "email"
  validates :phone_number, telephone_number: {country: :FR, types: [:fixed_line, :mobile], message: "Le numéro de téléphone n'est pas valide."}

  validates :email, uniqueness: { message: "Cette adresse email est déjà utilisée."}
    
  
  validates_confirmation_of :password, message: "Le mot de passe et la confirmation doivent être identiques."

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

  def send_admin_pickup_notification(booking, booking_products)
    UserMailer.notify_pickup_availability(self, booking, booking_products).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def custom_error_messages
    error_messages = errors.messages
    errors = error_messages.values_at(*(error_messages.keys - [:first_name, :last_name, :address, :city, :zip_code, :email, :password]))
    errors.flatten.join(' ')
  end

  def email_address_errors
    error_messages = errors.messages
    if error_messages.keys.include?(:email) && error_messages[:email] == ['Cette adresse email est déjà utilisée.']
      error_messages[:email_address] = ['Cette adresse email est déjà utilisée.']
      error_messages.delete(:email)
    end
  end

  def missing_field_messages
    missing_field_list = errors.messages.values_at(:first_name, :last_name, :address, :city, :zip_code, :email, :password).flatten.join(', ')
    'Merci de renseigner : ' + missing_field_list + '. '
  end

  def user_errors
    email_address_errors
    error_messages = errors.messages
    error_messages[:password_confirmation] = [ error_messages[:password_confirmation].first ]
    message = ''
    message += missing_field_messages if missing_fields?
    message + custom_error_messages
  end

  def missing_fields?
    !(errors.messages.keys & [:first_name, :last_name, :address, :city, :zip_code, :email, :password]).empty?
  end
  
end