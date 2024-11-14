class CartController < ApplicationController
  before_action :set_cart

  def add
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    cart_item = @cart.cart_items.find_by(product_id: product.id)
    if cart_item
      cart_item.update(quantity: cart_item.quantity + quantity)
    else
      @cart.cart_items.create(product: product, quantity: quantity)
    end

    render json: { status: 'success' }
  end

  def remove
    product_id = params[:product_id]
    cart_item = @cart.cart_items.find_by(product_id: product_id)
    cart_item.destroy if cart_item

    render json: { status: 'success' }
  end

  def show
    cart_items = @cart.cart_items.includes(:product).map do |item|
      {
        id: item.product.id,
        name: item.product.name,
        price: item.product.price,
        quantity: item.quantity,
        total_price: item.product.price * item.quantity,
        image_url: url_for(item.product.image) if item.product.image.attached?
      }
    end

    total = cart_items.sum { |item| item[:total_price] }
    render json: { cart_items: cart_items, total: total }
  end

  private

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] ||= @cart.id
  end
end
