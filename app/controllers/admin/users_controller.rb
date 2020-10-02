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

  private

  def user_params
    params.require('user').permit(:first_name, :last_name, :phone_number, :email)
  end

end