class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :except => [:home]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to jobs_path, :alert => exception.message
  end

  protected

  def configure_permitted_parameters

    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password,
    :password_confirmation, :role) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, 
    :password_confirmation, :current_password, :role) }

  end
end
