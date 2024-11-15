# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :authenticate_user!
  helper_method :current_user

  before_action :initialize_cart

  def authenticate_user!
    unless session[:user_id]
      redirect_to login_path, alert: "Debes iniciar sesión"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def initialize_cart
    if session[:user_id].present?
      @cart ||= Cart.find_by(user_id: session[:user_id])

      if session[:cart_id] && @cart.nil?
        @cart = Cart.find_by(id: session[:cart_id])
      elsif @cart.nil?
        @cart = Cart.create(user_id: session[:user_id])
      end

      return
    end

    @cart ||= Cart.find_by(id: session[:cart_id])

    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
