class CreateProductsProducts < ActiveRecord::Migration[5.1]

  def up
    create_table :refinery_products do |t|
      t.string :name
      t.text :body
      t.boolean :draft
      t.datetime :published_at
      t.integer :photo_id
      t.string :sku
      t.integer :available
      t.decimal :price
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-products"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/products/products"})
    end

    drop_table :refinery_products

  end

end
