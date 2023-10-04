require 'spec_helper'

module Refinery
  module Products
    describe Customer do
      describe "validations", type: :model do
        subject do
          FactoryBot.create(:customer,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
