# encoding: UTF-8

class PasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    user ? notify_reset(user) : notify_error('Cet email ne correspond à aucun utilisateur.', passwords_new_path)
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    @user.update(user_params) ? notify_update(@user.id) : notify_error('Le mot de passe et la confirmation doivent être identiques.', '/passwords/reset/' + params[:id])
  end

  def reset
    @user = User.find_by_password_reset_token(params[:id])
    notify_error("Le lien n'est plus valide. Recommencez la procédure s'il vous plaît.", passwords_new_path) if @user.nil?
    notify_error('La réinitialisation du mot de passe a expiré.', passwords_new_path) if @user&.password_reset_sent_at < 1.hour.ago
  end

  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def success_notification
    if browser_info.mobile? 
      'Nous vous avons envoyé un email.'
    else 
      'Un email vous a été envoyé avec des instructions.'
    end
  end

  def notify_reset(user)
    user.send_password_reset
    flash[:success] = success_notification
    redirect_to root_path
  end

  def notify_update(user_id)
    flash[:success] = 'Votre mot de passe a été réinitialisé.'
    session_store(user_id)
    redirect_to root_path
  end

  def notify_error(message, path)
    flash[:danger] = message
    redirect_to path
  end
end