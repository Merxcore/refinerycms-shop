module Refinery
  module Products
    class CustomersController < ::ApplicationController

      before_action :find_all_customers
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @customer in the line below:
        present(@page)
      end

      def show
        @customer = Customer.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @customer in the line below:
        present(@page)
      end

    protected

      def find_all_customers
        @customers = Customer.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/customers").first
      end

    end
  end
end
