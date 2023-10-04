class CreateProductsCustomers < ActiveRecord::Migration[5.1]

  def up
    create_table :refinery_products_customers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :stripe_customer
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-products"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/products/customers"})
    end

    drop_table :refinery_products_customers

  end

end
