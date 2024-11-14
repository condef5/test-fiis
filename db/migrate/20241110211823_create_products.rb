class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.string :brand
      t.integer :stock
      t.string :category

      t.timestamps
    end
  end
end
