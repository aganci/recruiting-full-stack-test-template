# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Product.create!(name: 'Cake Slice', image_url: 'products/cake-slice.png', description: 'A slice of cake!', selling_price: 4.99)
Product.create!(name: 'Cake Big', image_url: 'products/cake-big.png', description: 'A whole cake!', selling_price: 13.99)
Product.create!(name: 'Candy Green', image_url: 'products/candy-green.png', description: 'A very good candy', selling_price: 1.99)
Product.create!(name: 'Choko Cream', image_url: 'products/choko-cream.png', description: 'A delicious chocolate ice cream', selling_price: 2.99)
Product.create!(name: 'Cream Pink', image_url: 'products/cream-pink.png', description: 'A delicious pink ice cream', selling_price: 2.99)
Product.create!(name: 'Sweet Cream', image_url: 'products/sweet-cream.png', description: 'A sweet creamy ice cream', selling_price: 2.99)
