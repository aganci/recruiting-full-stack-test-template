require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:cart) { Cart.create }
  let(:product) { Product.create(name: 'Test Product', description: 'Test', image_url: 'test.png', selling_price: 10.00) }

  before do
    session[:cart_id] = cart.id
  end

  describe 'POST #create' do
    it 'adds a product to the cart' do
      expect {
        post :create, params: { product_id: product.id }
      }.to change { cart.reload.cart_items.count }.by(1)
    end

    it 'redirects to the product page' do
      post :create, params: { product_id: product.id }
      expect(response).to redirect_to(product_path(product))
    end

    it 'sets a notice flash message' do
      post :create, params: { product_id: product.id }
      expect(flash[:notice]).to eq('Product added to cart!')
    end

    context 'when product is already in cart' do
      before do
        cart.cart_items.create(product: product, quantity: 1, price: product.selling_price)
      end

      it 'increments the quantity instead of creating new item' do
        expect {
          post :create, params: { product_id: product.id }
        }.not_to change { cart.reload.cart_items.count }

        cart_item = cart.cart_items.find_by(product: product)
        expect(cart_item.quantity).to eq(2)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:cart_item) { cart.cart_items.create(product: product, quantity: 2, price: product.selling_price) }

    it 'removes the item from the cart' do
      expect {
        delete :destroy, params: { id: cart_item.id }
      }.to change { cart.reload.cart_items.count }.by(-1)
    end

    it 'redirects to the cart page' do
      delete :destroy, params: { id: cart_item.id }
      expect(response).to redirect_to(cart_path)
    end

    it 'sets a notice flash message' do
      delete :destroy, params: { id: cart_item.id }
      expect(flash[:notice]).to eq('Product removed from cart.')
    end
  end

  describe 'PATCH #update' do
    let!(:cart_item) { cart.cart_items.create(product: product, quantity: 2, price: product.selling_price) }

    it 'updates the quantity of the cart item' do
      patch :update, params: { id: cart_item.id, quantity: 5 }
      expect(cart_item.reload.quantity).to eq(5)
    end

    it 'redirects to the cart page' do
      patch :update, params: { id: cart_item.id, quantity: 5 }
      expect(response).to redirect_to(cart_path)
    end
  end
end
