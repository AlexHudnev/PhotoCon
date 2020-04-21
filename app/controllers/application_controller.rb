# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
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
    render 'errors/error404'
  end

  def verify_authenticity_token
    # token = request.headers['token']
    # @api_user = User.find_by(authenticity_token: token)
    # raise ::Errors::InvalidCredentials unless @api_user
  end

  helper_method :current_user
  helper_method :verify_authenticity_token
end
