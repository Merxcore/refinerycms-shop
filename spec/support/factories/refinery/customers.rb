
FactoryBot.define do
  factory :customer, :class => Refinery::Products::Customer do
    sequence(:name) { |n| "refinery#{n}" }
  end
end

