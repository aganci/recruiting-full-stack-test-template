require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #show' do
    let(:cart) { Cart.create }

    before do
      session[:cart_id] = cart.id
    end

    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'assigns @cart' do
      get :show
      expect(assigns(:cart)).to eq(cart)
    end

    it 'renders the show template' do
      get :show
      expect(response).to render_template(:show)
    end

    context 'when cart has items' do
      let(:product) { Product.create(name: 'Test Product', description: 'Test', image_url: 'test.png', selling_price: 10.00) }

      before do
        cart.cart_items.create(product: product, quantity: 2, price: product.selling_price)
      end

      it 'displays cart items' do
        get :show
        expect(assigns(:cart).cart_items.count).to eq(1)
      end
    end
  end
end
