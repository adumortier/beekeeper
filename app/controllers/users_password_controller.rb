# encoding: UTF-8

class UsersPasswordController < ApplicationController


  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params) ? notify_update : notify_error
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def notify_update
    flash[:success] = 'Votre mot de passe a été mis à jour.'
    redirect_to profile_path
  end

  def notify_error
    flash[:danger] = 'Le mot de passe et la confirmation doivent être identiques.'
    redirect_to user_password_edit_path
  end

end