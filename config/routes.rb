Refinery::Core::Engine.routes.draw do

  # Frontend Product routes
  namespace :products do
    resources :products, :path => '', :only => [:index, :show]
  end
  resources :orders, :only => [:show, :create, :update] do
    post :checkout
    get :success
    get :canceled
  end

  # Admin routes
  namespace :products, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

  # Admin routes
  namespace :products, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/products" do
      resources :orders, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
