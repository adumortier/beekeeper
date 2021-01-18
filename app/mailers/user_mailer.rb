class UserMailer < ApplicationMailer

  def forgot_password(user)
    @user = user
    @greeting = "Hi"
  
    mail(
      reply_to: ENV["GMAIL_USERNAME"],
      to: @user.email,
      subject: 'Reset password instructions'
    )
  end

end
