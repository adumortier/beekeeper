# encoding: UTF-8

class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login(user)
      flash[:success] = "Bienvenue #{user.first_name}!"
    else
      flash[:error] = "Email ou mot de passe incorrect"
      redirect_to login_path and return
    end
    redirect_to root_path
  end

  def destroy
    session[:user] = nil
    flash[:success] = "Vous avez été déconnecté(e)"
    redirect_to root_path
  end

end