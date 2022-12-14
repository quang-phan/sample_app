class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :find_user_by_id, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :translate_pagy, only: :index

  def index
    @pagy, @users = pagy User.order_name_by_asc
  end

  def new
    @user = User.new
  end

  def show
    @pagy, @microposts = pagy @user.microposts
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".email_activation"
      redirect_to root_path
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".error"
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t ".edit_error_message"
    redirect_to root_path
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t ".delete_error_message"
    redirect_to root_path
  end

  def translate_pagy
    @pagy_locale = params[:locale]
  end
end
