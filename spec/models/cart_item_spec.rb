RSpec.describe CartItem do
  describe 'model' do
    it { is_expected.to have_db_column(:cart_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:product_id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:price).of_type(:decimal).with_options(null: false, precision: 9, scale: 2) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:cart).required }
    it { is_expected.to belong_to(:product).required }
  end
end
