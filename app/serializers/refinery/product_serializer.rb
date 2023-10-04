require "active_model_serializers"
module Refinery
    class ProductSerializer < ActiveModel::Serializer
        attributes :id, :name, :body, :price, :photo_id
    end
end