require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let!(:product1) { Product.create(name: 'Product 1', description: 'Test 1', image_url: 'test1.png', selling_price: 10.00) }
    let!(:product2) { Product.create(name: 'Product 2', description: 'Test 2', image_url: 'test2.png', selling_price: 20.00) }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns @products with all products' do
      get :index
      expect(assigns(:products)).to match_array([product1, product2])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:product) { Product.create(name: 'Test Product', description: 'Test', image_url: 'test.png', selling_price: 10.00) }

    it 'returns http success' do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end

    it 'assigns @product' do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it 'renders the show template' do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end

    context 'when product does not exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        expect {
          get :show, params: { id: 99999 }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
