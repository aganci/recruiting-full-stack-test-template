class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total_price
    cart_items.sum { |item| item.price * item.quantity }
  end

  def total_items
    cart_items.sum(:quantity)
  end

  def add_product(product, quantity = 1)
    current_item = cart_items.find_by(product_id: product.id)

    if current_item
      current_item.increment!(:quantity, quantity)
    else
      cart_items.create(product: product, quantity: quantity, price: product.selling_price)
    end
  end
end
