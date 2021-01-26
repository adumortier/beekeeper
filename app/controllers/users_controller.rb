# encoding: UTF-8
class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:welcome] = "Bienvenue #{@user.first_name}!"
      session[:user] = @user.id
      redirect_to root_path
    else
      flash[:danger] = @user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    if @user.save
      flash[:success] = "Votre profil a été mis à jour."
      redirect_to profile_path
    else
      flash[:danger] = @user.errors.messages.values[0][0]
      redirect_to profile_edit_path
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :phone_number, :password, :password_confirmation)
  end
end

