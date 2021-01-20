# encoding: UTF-8

class UsersPasswordController < ApplicationController


  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'Votre mot de passe a été mis à jour'
      redirect_to profile_path and return
    else 
      flash[:danger] = 'Le mot de passe et la confirmation sont différents'
      redirect_to user_password_edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip_code, :email, :password, :password_confirmation)
  end

end