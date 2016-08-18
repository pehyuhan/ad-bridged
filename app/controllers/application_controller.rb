class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  helper_method :current_user

private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
    #current_user.locale
    #request.subdomain
    #request.env["HTTP_ACCEPT_LANGUAGE"]
    #request.remote_ip
  end
  
  def default_url_options(options = {})
      {locale: I18n.locale}
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end