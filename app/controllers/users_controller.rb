# encoding: UTF-8
class UsersController < BaseController

  skip_before_action :require_current_user, only: %i[create new]

  def show
    @user = current_user.decorate
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.create(user_params)
    @user.valid? ? log_user_in(@user.first_name, @user.id) : notify_errors(@user.user_errors, 'users/new')
  end

  def update
    @user = User.find(current_user.id)
    @user.assign_attributes(user_params)
    user_updated = @user.changed?
    @user.save ? notify_update(user_updated) : notify_errors(@user.user_errors, 'users/edit')
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :address,
                                 :city,
                                 :zip_code,
                                 :phone_number,
                                 :password,
                                 :password_confirmation)
  end

  def log_user_in(name, id)
    flash[:success] = "Bienvenue #{name} !"
    session_store(id)
    redirect_to root_path
  end

  def notify_update(updated)
    flash[:success] = 'Votre profil a été mis à jour.' if updated
    redirect_to profile_path
  end

  def notify_errors(errors, view)
    flash.now[:danger] = errors
    render view
  end

end

