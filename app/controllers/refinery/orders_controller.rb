
module Refinery

  class OrdersController < ::ApplicationController
      protect_from_forgery with: :null_session

      before_action :find_all_orders
      before_action :find_page

      # fix for LoadError (Unable to autoload constant Refinery::Order::Order
      require 'refinery/order/order'

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @order in the line below:
        present(@page)
      end

      def show
        @order = Refinery::Products::Order.find(params[:id])
        @cart = @order
        @checkout = true

        # only show order associated with current session/user
        if @order.session_id != session.id
          # redirect and notify why
          flash[:notice] = "Order not found"
          redirect_to '/products'
        end

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @order in the line below:
        respond_to do |format|
          format.html { present(@order) }
          format.json { render json: Refinery::OrderSerializer.new(@order).as_json }
        end
      end

      def create
        # Get orders based on the session ID
        order = Refinery::Products::Order.where(session_id: session.id).first_or_create
        # Product ID
        product = Refinery::Products::Product.find(params['product_id'])
        # Add Product
        op = Refinery::Products::OrderProduct
          .where(order_id: order.id, product_id: product.id).first
        if op.nil?
          Refinery::Products::OrderProduct.create(order_id: order.id,
            product_id: product.id)
        else
          # TODO handling for if quantity exceeding availablility
          #   additional check at checkout necessary?
          op.increment!(:quantity)
        end
        # Return products in order
        # render json: Refinery::OrderSerializer.new(order).as_json
        @cart = order
        respond_to do |format|
          format.js
        end
      end

      def update
        order = Refinery::Products::Order.where(session_id: session.id).first_or_create
        # Get delete OrderProduct Instance as needed
        # TODO https://github.com/refinery/refinerycms-blog/issues/227
        # Change quantity
        if params['quantity'].to_i == 0
          Refinery::Products::OrderProduct.delete(Refinery::Products::OrderProduct.where(product_id: params['product_id'], order_id: order.id).first.id)
        else
          order.orderproducts.where(product: params['product_id'])
            .update(quantity: params['quantity'])
        end
        @cart = order
        respond_to do |format|
          format.js { render :create }
        end
      end

      def checkout
        # require 'stripe'
        # TODO session check again?
        order = Refinery::Products::Order.find(params[:order_id])
        # build price data
        line_items = []

        order.flat_products.each do |product|
          line_item = {
            price_data: {
              unit_amount: product.price.to_i * 100,
              currency: 'usd',
              product_data: {
                name: product.name,
                images: [product.photo_link],
              },
            },
            quantity: order.product_quantity(product)
          }
          line_items << line_item
        end

        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          billing_address_collection: 'auto',
          shipping_address_collection: {
            allowed_countries: ['US'],
          },
          # adjust line_items & product_data from order
          line_items: line_items,

          # [{
          #   price_data: {
          #     # adjust total from dollars to cents
          #     unit_amount: order.total * 100,
          #     currency: 'usd',
          #     product_data: {
          #       name: 'Carolina Wild Harvests',
          #       images: ['https://i.imgur.com/EHyR2nP.png'],
          #     },
          #   },
          #   quantity: 1,
          # }]

          mode: 'payment',
          success_url: DOMAIN + order_success_path(order) + "?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: DOMAIN + order_canceled_path(order) + "?session_id={CHECKOUT_SESSION_ID}",
        })
        respond_to do |format|
          format.js { render :json => {id: session.id} }
        end
      end

      def success
        session = Stripe::Checkout::Session.retrieve(params[:session_id])
        order = Refinery::Products::Order.where(session_id: session.id).first
        # create user
        address = session.shipping.address.line1 + " " + session.shipping.address.line1
        address = address + " " + session.shipping.address.city
        address = address + " " + session.shipping.address.state
        address = address + " " + session.shipping.address.country
        address = address + " " + session.shipping.address.postal_code
        customer = Refinery::Products::Customer.where(
          email: session.customer_details.email,
          address: address, stripe_customer: session.customer).first_or_create
        # if paid update order
        if session.payment_status == "paid"
          order.update(paid: true, date_paid: DateTime.now, user_id: customer.id)
        else
          # something went wrong
        end
      end

      def canceled
        @order = Refinery::Products::Order.find(params[:order_id])
      end

    protected

      def find_all_orders
        @orders = Refinery::Order::Order.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/orders").first
      end
  end
end
