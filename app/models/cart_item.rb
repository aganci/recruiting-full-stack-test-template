class CartItem < ApplicationRecord
  belongs_to :cart, optional: false
  belongs_to :product, optional: false
end
