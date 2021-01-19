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

end
