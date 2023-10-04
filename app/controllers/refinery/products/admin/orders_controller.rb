module Refinery
  module Products
    module Admin
      class OrdersController < ::Refinery::AdminController

        crudify :'refinery/products/order'

        private

        # Only allow a trusted parameter "white list" through.
        def order_params
          params.require(:order).permit(:paid, :date_paid, :user_id)
        end
      end
    end
  end
end
