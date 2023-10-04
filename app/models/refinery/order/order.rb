module Refinery
  module Order
    class Order < Refinery::Core::BaseModel
      self.table_name = 'refinery_orders'


      # def title was created automatically because you didn't specify a string field
      # when you ran the refinery:engine generator. <3 <3 Refinery CMS.
      def title
        "Override def title in vendor/extensions/order/app/models/refinery/order/order.rb"
      end

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
