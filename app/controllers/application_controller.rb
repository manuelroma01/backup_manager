class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  
  # rescata excepciones de acceso prohibido (cancan)
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
