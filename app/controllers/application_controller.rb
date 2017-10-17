class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :devise_controller?

  # call configured params
  before_action :configure_permitted_parameters, if: :devise_controller?

  # strong parameters: protect database , while allowing these fields to be updated
  protected 
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me)}
  	devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :password_confirmation, :remember_me)}
  	devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :remember_me)}
  end

  def authenticate_user!
    unless user_signed_in?
      flash[:notice] = "You need to login."
      redirect_to root_path
    end
  end

end
