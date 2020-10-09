# encoding: UTF-8
class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @bookings = Booking.joins(:user).where('email = ?', @user.email)
  end

  def edit
    @user = User.find(params[:id])
    @bookings = Booking.joins(:user).where('email = ?', @user.email)
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to "/admin/users/#{@user.id}"
  end

  def index
    @users = (params[:sort].present? ? load_users : User.where(role: 0))
  end

  def delete
    User.find(params[:id]).destroy
    redirect_to "/admin/users"
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:success] = "Le nouvel utilisateur a été ajouté"
      redirect_to "/admin/users"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to '/admin/users/new'
    end
  end

  private

  def user_params
    params.require('user').permit(:first_name, :last_name, :phone_number, :email, :created_at, :password, :password_confirmation)
  end

end