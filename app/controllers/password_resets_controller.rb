class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration,
                only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase

    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t ".info_email_sended"
      redirect_to root_path
    else
      flash.now[:danger] = t ".not_found_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      empty_password_error
    elsif @user.update user_params
      success_update
    else
      invalid_password
    end
  end

  private
  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]

    return if @user.present?

    flash[:danger] = t ".user_not_found"
    redirect_to root_path
  end

  def valid_user
    return if @user&.activated? && @user&.authenticated?(:reset,
                                                         params[:id])

    redirect_to root_path
  end

  def check_expiration
    return unless @user.password_reset_expried?

    flash[:danger] = t ".password_reset_expried"
    redirect_to new_password_reset_path
  end

  def empty_password_error
    @user.errors.add :password, t(".empty_password_error")
    render :edit
  end

  def success_update
    log_in @user
    flash[:success] = t ".success_update"
    redirect_to @user
  end

  def invalid_password
    flash.now[:danger] = t ".invalid_password"
    render :edit
  end
end
