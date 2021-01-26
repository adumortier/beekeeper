# encoding: UTF-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      login(user)
      flash[:success] = "Bienvenue #{user.first_name}!"
    else
      flash[:danger] = "Email ou mot de passe incorrect"
      redirect_to login_path and return
    end
    redirect_to (current_user.admin? ? root_path : reservation_path)
  end

  def destroy
    session[:user] = nil
    redirect_to root_path
  end

end