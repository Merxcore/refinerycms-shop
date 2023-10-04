module Refinery
  module Products
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Products

      engine_name :refinery_products

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "orders"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.products_admin_orders_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/products/orders(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Orders)
      end
    end
  end
end
