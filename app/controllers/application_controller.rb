class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Devise will redirect to the login page unless on the home page
  before_action :authenticate_user!, except: [:home]

  # call configured params
  before_action :configure_permitted_parameters, if: :devise_controller?

  # strong parameters: protect database , while allowing these fields to be updated
  protected 
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me)}
  	devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :password_confirmation, :remember_me)}
  	devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :remember_me)}
  end


end
