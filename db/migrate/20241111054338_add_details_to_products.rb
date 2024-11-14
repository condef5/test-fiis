class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :material, :string
    add_column :products, :dimension, :string
    add_column :products, :peso, :string
    add_column :products, :color, :string
    add_column :products, :caracteristicas, :text
  end
end
