require 'spec_helper'

module Refinery
  module Products
    describe Order do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:order)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
