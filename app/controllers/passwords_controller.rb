# encoding: UTF-8

class PasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset 
      if browser_info.mobile?
        flash[:success] = 'Nous vous avons envoyé un email.'
      else
        flash[:success] = 'Un email vous a été envoyé avec des instructions.'
      end
      redirect_to root_path
    else
      flash[:danger] = 'Cet email ne correspond à aucun utilsateur existant.'
      redirect_to passwords_new_path
    end
  end

  def reset
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hour.ago
    flash[:danger] = 'La réinitialisation du mot de passe a expiré.'
    redirect_to passwords_new_path
  elsif @user.update(user_params)
    flash[:success] = 'Votre mot de passe a été réinitialisé.'
    session[:user] = @user.id
    redirect_to root_path
  else
    flash[:danger] = 'Le mot de passe et la confirmation doivent être identiques.'
    redirect_to "/passwords/reset/#{params[:id]}"
  end
end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end