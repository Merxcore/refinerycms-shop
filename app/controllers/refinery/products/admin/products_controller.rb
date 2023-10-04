module Refinery
  module Products
    module Admin
      class ProductsController < ::Refinery::AdminController

        crudify :'refinery/products/product',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def product_params
          params.require(:product).permit(:name, :body, :draft, :published_at, :photo_id, :sku, :available, :price)
        end
      end
    end
  end
end
