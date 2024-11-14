# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    helper_method :authenticate_user!
  
    def authenticate_user!
      unless session[:user_id]
        redirect_to login_path, alert: 'Debes iniciar sesión'
      end
    end
  end
  