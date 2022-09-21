class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)

    if @user&.authenticate(params[:session][:password])
      checking_user_activation
    else
      flash.now[:danger] = t ".error_message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def checking_remember_user
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
  end

  def checking_user_activation
    if @user.activated?
      log_in @user
      checking_remember_user
      redirect_back_or @user
    else
      flash[:warning] = t ".account_activation_error"
      redirect_to root_path
    end
  end
end
