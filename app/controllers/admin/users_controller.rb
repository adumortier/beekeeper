# encoding: UTF-8
class Admin::UsersController < Admin::BaseController

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
    redirect_to admin_user_path
  end

  def index
    @users = (params[:sort].present? ? load_users : User.where(role: 0))
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:success] = "Le nouvel utilisateur a été ajouté"
      redirect_to admin_users_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to new_admin_user_path
    end
  end

  private

  def user_params
    params.require('user').permit(:first_name, :last_name, :phone_number, :email, :address, :created_at, :password, :password_confirmation)
  end

end