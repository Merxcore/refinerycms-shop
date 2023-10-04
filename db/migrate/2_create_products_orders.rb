class CreateProductsOrders < ActiveRecord::Migration[5.1]

  def up
    create_table :refinery_products_orders do |t|
      t.boolean :paid, default: false
      t.date :date_paid
      t.integer :user_id
      t.integer :position

      t.timestamps
    end

    # create_join_table :products, :orders

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-products"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/products/orders"})
    end

    drop_table :refinery_products_orders
    drop_join_table :products, :orders
  end

end
