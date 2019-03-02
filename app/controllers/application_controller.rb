# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  config.before_action :set_admin_locale
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_admin_locale
    I18n.locale = :ru
  end
  helper_method :current_user
end
