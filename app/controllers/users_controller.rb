# encoding: UTF-8
class UsersController < BaseController

  skip_before_action :require_current_user, only: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      flash[:success] = "Bienvenue #{@user.first_name} !"
      session[:user] = @user.id
      redirect_to root_path
    else
      flash[:danger] = @user.user_errors
      redirect_to register_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    @user.assign_attributes(user_params)
    user_was_updated = @user.changed?
    if @user.save
      flash[:success] = "Votre profil a été mis à jour." if user_was_updated
      redirect_to profile_path
    else
      flash[:danger] = @user.user_errors
      redirect_to profile_edit_path
    end
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :city, :zip_code, :phone_number, :password, :password_confirmation)
  end

end

