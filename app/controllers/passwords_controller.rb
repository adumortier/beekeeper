# encoding: UTF-8

class PasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:notice] = 'E-mail sent with password reset instructions.'
    redirect_to root_path
  end

  def reset
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hour.ago
    flash[:notice] = 'La réinitialisation du mot de passe a expiré.'
    redirect_to passwords_new_path
  elsif @user.update(user_params)
    flash[:notice] = 'Votre mot de passe a été réinitialisé'
    session[:user] = @user.id
    redirect_to root_path
  else
    render :edit
  end
end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password)
  end

end