class AddIdToOrderProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :orders_products, :id, :primary_key
  end
end
