class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
   before_action :configure_permitted_parameters, if: :devise_controller?
  

  def authenticate
    unless ENV['HTTP_AUTH_USERNAME'].blank? or ENV['HTTP_AUTH_PASSWORD'].blank?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USERNAME'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    end
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end
   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:description,:email, :phone, :photo_url, :nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name,:description,:email, :phone, :photo_url, :nickname])
end

end
