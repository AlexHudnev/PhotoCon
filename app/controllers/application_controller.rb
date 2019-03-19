# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include ActiveSupport::Rescuable
  config.before_action :set_admin_locale
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_admin_locale
    I18n.locale = :ru
  end

  def not_found
    render xml: exception, status: 500
  end
  helper_method :current_user
end
