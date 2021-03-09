# encoding: UTF-8
class Admin::UsersController < Admin::BaseController

  def index
    @users = (params[:sort].present? ? load_users : User.default.decorate)
  end

  def show
    @user = User.find(params[:id]).decorate
    @bookings = Booking.user_bookings(@user.email).decorate
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id]).decorate
    @bookings = Booking.user_bookings(@user.email).decorate
  end

  def create
    @user = User.create(user_params)
    @user.valid? ? notify_creation : notify_errors(@user.user_errors, 'admin/users/new')
  end

  def update
    @user = User.find(params[:id])
    @bookings = Booking.user_bookings(@user.email).decorate
    @user.assign_attributes(user_params)
    user_updated = @user.changed?
    @user.save ? notify_update(user_updated) : notify_errors(@user.user_errors, 'admin/users/edit')
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require('user').permit(:first_name,
                                  :last_name,
                                  :phone_number,
                                  :email,
                                  :address,
                                  :city,
                                  :zip_code,
                                  :created_at,
                                  :password,
                                  :password_confirmation)
  end

  def notify_update(updated)
    flash[:success] = 'Le profil a été mis à jour.' if updated
    redirect_to admin_user_path
  end

  def notify_creation
    flash[:success] = 'Le nouvel utilisateur a été ajouté.'
    redirect_to admin_users_path
  end

  def notify_errors(errors, view)
    flash.now[:danger] = errors
    render view
  end

end