class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!, except: %i[ index show summary_and_critics ]
  before_action :authenticate_user!, except: %i[index show]

  protected

  # Para permitir mas parametros en un formulario

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username])
  end
end
