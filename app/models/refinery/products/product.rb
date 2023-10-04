module Refinery
  module Products
    class Product < Refinery::Core::BaseModel
      self.table_name = 'refinery_products'

      validates :name, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'
      has_many_page_images

      has_many :orderproducts, :class_name => 'Refinery::Products::OrderProduct'
      has_and_belongs_to_many :orders, through: :orderproducts

      after_create :sync_stripe_products

      # Add domain to photo url path
      def photo_link
        return "https://carolinawildharvests.com" + photo.url
      end


    private
      def sync_stripe_products
        # byebug
      end

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]


      # -[+] TODOs
      # -   After save update published_at
      # -   Stripe integration & shopping cart
      # -   Sync with Stripe after create
      # -   Images slideshow
      # -   SEO optimize pages (title & header tags, data tags, etc)
    end
  end
end
