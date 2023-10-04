class AddSessionIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :refinery_products_orders, :session_id, :string
  end
end
