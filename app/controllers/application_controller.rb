class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # user redirected to user show page after sign in
  def after_sign_in_path_for(resource)
  	root
  end

  # add new strong parameters to devise sign up
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :username) }
  end
end
