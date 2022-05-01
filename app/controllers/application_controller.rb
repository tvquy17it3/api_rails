class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    if params[:locale].present?
      cookies.permanent[:locale] = params[:locale] # save cookies
    end

    locale = cookies[:locale]&.to_sym # read cookies

    if I18n.available_locales.include?(locale)
      I18n.locale = locale # use cookies locale
    end
  end

  def after_sign_in_path_for(resource)
    admin_users_path
  end
end
