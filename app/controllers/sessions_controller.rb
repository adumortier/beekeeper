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
      redirect_to '/login'
    end    
    redirect_to current_admin ? '/admin' : '/'
  end

  def destroy
    session[:user] = nil
    flash[:success] = "Vous avez été déconnecté(e)"
    redirect_to '/'
  end

end