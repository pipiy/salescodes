class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name,
    :last_name, :short_bio, :password, :password_confirmation, :current_password, :avatar, :remote_avatar_url) }
  end
end
