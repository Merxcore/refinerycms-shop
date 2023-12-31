module Refinery
  module Products
    class ProductsController < ::ApplicationController

      before_action :find_all_products
      before_action :find_page

      before_action :load_cart

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end


      def show
        @product = Product.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @product in the line below:
        present(@page)
      end


    protected

      def find_all_products
        @products = Product.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/products").first
      end

      def load_cart
        @cart = Refinery::Products::Order.where(session_id: session.id).first_or_create
      end

    end
  end
end
