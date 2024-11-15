class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def total
    cart_items.to_a.sum { |cart_item| cart_item.total }
  end

  def count
    cart_items.to_a.sum { |cart_item| cart_item.quantity }
  end
end
