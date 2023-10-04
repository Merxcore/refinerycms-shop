module Refinery
  module Products
    class Order < Refinery::Core::BaseModel
      has_many :orderproducts, :class_name => 'Refinery::Products::OrderProduct'
      has_and_belongs_to_many :products, through: :orderproducts,
        join_table: 'orders_products',
        foreign_key: 'order_id',
        association_foreign_key: 'product_id'


      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Order #{id}"
      end

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      def total
        products.map(&:price).sum
      end

      def flat_products
        products.uniq
      end

      def product_quantity(product)
        orderproducts.where(product_id: product).first.quantity
      end

    end
  end
end
