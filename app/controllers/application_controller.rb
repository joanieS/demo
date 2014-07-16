class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_customer

  # user redirected to user show page after sign in
  def after_sign_in_path_for(resource)
  	root_path
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation) }
  end

  private
    def set_customer
      @customer = Customer.find(current_user.customer_id)
    end
end
