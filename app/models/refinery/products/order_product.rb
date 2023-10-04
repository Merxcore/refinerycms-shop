module Refinery
    module Products
      class OrderProduct < Refinery::Core::BaseModel
        self.table_name = 'orders_products'
        belongs_to :order
        belongs_to :product
        has_and_belongs_to_many :products, join_table: 'orders_products'

      end
    end
  end
