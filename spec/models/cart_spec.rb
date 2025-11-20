RSpec.describe Cart do
  describe 'model' do
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:cart_items) }
  end

  describe '#total_price' do
    let(:cart) { Cart.create }
    let(:product1) { Product.create(name: 'Product 1', description: 'Test', image_url: 'test.png', selling_price: 10.00) }
    let(:product2) { Product.create(name: 'Product 2', description: 'Test', image_url: 'test.png', selling_price: 5.00) }

    it 'returns 0 for an empty cart' do
      expect(cart.total_price).to eq(0)
    end

    it 'calculates the total price of all items in the cart' do
      cart.cart_items.create(product: product1, quantity: 2, price: product1.selling_price)
      cart.cart_items.create(product: product2, quantity: 1, price: product2.selling_price)

      expect(cart.total_price).to eq(25.00)
    end

    it 'uses the stored price from cart items, not current product price' do
      cart.cart_items.create(product: product1, quantity: 1, price: 8.00)
      product1.update(selling_price: 10.00)

      expect(cart.total_price).to eq(8.00)
    end
  end

  describe '#total_items' do
    let(:cart) { Cart.create }
    let(:product1) { Product.create(name: 'Product 1', description: 'Test', image_url: 'test.png', selling_price: 10.00) }
    let(:product2) { Product.create(name: 'Product 2', description: 'Test', image_url: 'test.png', selling_price: 5.00) }

    it 'returns 0 for an empty cart' do
      expect(cart.total_items).to eq(0)
    end

    it 'sums the quantity of all items in the cart' do
      cart.cart_items.create(product: product1, quantity: 2, price: product1.selling_price)
      cart.cart_items.create(product: product2, quantity: 3, price: product2.selling_price)

      expect(cart.total_items).to eq(5)
    end
  end

  describe '#add_product' do
    let(:cart) { Cart.create }
    let(:product) { Product.create(name: 'Product', description: 'Test', image_url: 'test.png', selling_price: 10.00) }

    context 'when product is not in cart' do
      it 'creates a new cart item with quantity 1' do
        expect {
          cart.add_product(product)
        }.to change { cart.cart_items.count }.by(1)

        cart_item = cart.cart_items.last
        expect(cart_item.product).to eq(product)
        expect(cart_item.quantity).to eq(1)
        expect(cart_item.price).to eq(product.selling_price)
      end

      it 'creates a new cart item with specified quantity' do
        cart.add_product(product, 3)

        cart_item = cart.cart_items.last
        expect(cart_item.quantity).to eq(3)
      end
    end

    context 'when product is already in cart' do
      before do
        cart.cart_items.create(product: product, quantity: 2, price: product.selling_price)
      end

      it 'increments the quantity of the existing cart item' do
        expect {
          cart.add_product(product)
        }.not_to change { cart.cart_items.count }

        cart_item = cart.cart_items.find_by(product: product)
        expect(cart_item.quantity).to eq(3)
      end

      it 'increments by specified quantity' do
        cart.add_product(product, 5)

        cart_item = cart.cart_items.find_by(product: product)
        expect(cart_item.quantity).to eq(7)
      end
    end
  end
end
