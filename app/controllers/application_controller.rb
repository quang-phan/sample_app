class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  private
  before_action :set_locale
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".message"
    redirect_to login_path
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".error_messages"
    redirect_to root_path
  end
end
