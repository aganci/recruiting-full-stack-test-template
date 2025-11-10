class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.text :description, null: false
      t.decimal :selling_price, null: false, precision: 9, scale: 2

      t.timestamps
    end
  end
end
