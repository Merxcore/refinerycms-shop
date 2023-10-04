class AddQuantityToOrderProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_products, :quantity, :integer, :default => 1
  end
end
