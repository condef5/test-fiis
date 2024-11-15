class AuthController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to new_products_upload_path, notice: "Sesión iniciada correctamente"
    else
      flash.now[:alert] = "Usuario o contraseña incorrectos"
      render :new
    end
  end
end
