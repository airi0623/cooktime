class ApplicationController < ActionController::Base
  # before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:family_name,:first_name,:profile,:icon])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname,:family_name,:first_name,:profile,:icon])
  end

  private
  
  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
  #   end
  # end

  # registrations_controller.rb と passwords_controller.rb の check_guest は削除
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@gmail.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
