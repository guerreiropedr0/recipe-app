class ApplicationController < ActionController::Base
  rescue_from 'CanCan::AccessDenied' do |_exception|
    redirect_to root_path, alert: 'You are not authorized to access this page.'
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: %i[email name password password_confirmation]
    )
  end
end
