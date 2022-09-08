class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]

    user_activation user
  end

  private
  def user_activation user
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      user.update activated: true, activated_at: Time.zone.now
      log_in user
      flash[:success] = t ".success_activation"
      redirect_to user
    else
      flash[:danger] = t ".fail_activation"
      redirect_to root_path
    end
  end
end
