class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    ActiveRecord::Base.transaction do
      order = Order.create(user: current_user, total: @cart.total)

      @cart.cart_items.each do |cart_item|
        OrderDetail.create(
          order: order,
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price,
        )
      end

      @cart.destroy
      session[:cart_id] = nil
    end

    redirect_to root_path, notice: "Orden creada exitosamente!"
  end
end
