class CartItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    current_cart.add_product(product)

    redirect_to product_path(product), notice: "Product added to cart!"
  end

  def destroy
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.destroy

    redirect_to cart_path, notice: "Product removed from cart."
  end

  def update
    cart_item = current_cart.cart_items.find(params[:id])
    cart_item.update(quantity: params[:quantity])

    redirect_to cart_path
  end
end
