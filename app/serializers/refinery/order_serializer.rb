require "active_model_serializers"
module Refinery
    class OrderSerializer < ActiveModel::Serializer
        puts "concern"
        has_many :orderproducts 
        attributes :id, :paid
    end
end