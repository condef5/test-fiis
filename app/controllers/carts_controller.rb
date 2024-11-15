class CartsController < ApplicationController
  def show
  end

  def create
    @product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    current_cart_item = @cart.cart_items.find_by(product_id: @product.id)

    if current_cart_item && quantity > 0
      current_cart_item.update!(quantity: current_cart_item.quantity + quantity)
    elsif quantity <= 0 && current_cart_item
      current_cart_item.destroy!
    else
      @cart.cart_items.create!(product: @product, quantity: quantity)
    end

    flash[:notice] = "#{@product.name} fue añadido al carrito."
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart_item = CartItem.find(params[:cart_item_id])
    @cart_item.destroy!

    flash[:notice] = "#{@cart_item.product.name} fue eliminado del carrito."
    redirect_back(fallback_location: root_path)
  end
end
