# encoding: UTF-8

class SessionsController < ApplicationController

  def new 
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    user&.authenticate(params[:password]) ? log_user_in(user.id, user.first_name) : notify_error
  end

  def destroy
    clear_session
    flash[:success] = 'Vous avez été déconnecté(e).'
    redirect_to root_path
  end

  private

  def log_user_in(user_id, first_name)
    session_store(user_id)
    flash[:success] = "Bienvenue #{first_name} !"
    redirect_to (current_user.admin? ? root_path : reservation_path)
  end

  def notify_error
    flash[:danger] = 'Email ou mot de passe incorrect.'
    redirect_to login_path
  end

  def clear_session
    session[:user] = nil
  end

end