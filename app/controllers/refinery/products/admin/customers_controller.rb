module Refinery
  module Products
    module Admin
      class CustomersController < ::Refinery::AdminController

        crudify :'refinery/products/customer',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def customer_params
          params.require(:customer).permit(:name, :email, :address, :stripe_customer)
        end
      end
    end
  end
end
