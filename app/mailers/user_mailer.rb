# encoding: UTF-8
class UserMailer < ApplicationMailer

  def forgot_password(user)
    @user = user
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: "Les Filles d'Antoine | Réinitialisation de votre mot de passe"
    )
  end

  def confirm_booking(user, booking)
    @user = user
    @booking = booking
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: "Les Filles d'Antoine | Confirmation de réservation"
    )
  end

  def confirm_booking_change(user, booking)
    @user = user
    @booking = booking
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: "Les Filles d'Antoine | Modification de réservation"
    )
  end

  def confirm_admin_booking(user, booking)
    @user = user
    @booking = booking
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: "Les Filles d'Antoine | Confirmation de réservation"
    )
  end

  def message_to_admin(user, booking)
    @user = user
    @booking = booking
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: ENV["GMAIL_USERNAME"],
      subject: @user.first_name + ' ' + @user.last_name + ' vous a réservé des pots !'
    )
  end

  def notify_pickup_availability(user, booking, booking_products)
    @user = user
    @booking = booking
    @booking_products = booking_products
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: "Les Filles d'Antoine | Votre réservation est prête !"
    )
  end
end
