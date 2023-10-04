module Refinery
  module Order
    module Admin
      class OrdersController < ::Refinery::AdminController

        crudify :'refinery/order/order'

        private

        # Only allow a trusted parameter "white list" through.
        def order_params
          params.require(:order).permit(:products_id, :paid, :date_paid, :user_id)
        end
      end
    end
  end
end
