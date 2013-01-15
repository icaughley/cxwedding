Cxwedding::Application.routes.draw do

  root :to => 'gifts#index'

  devise_for :users

  resources :gifts do
    member do
      post :link_user
      post :unlink_user
    end
  end

  resources :users do
    put 'toggle_admin'
  end

  resources :dropbox_images, only: [:index, :show, :destroy] do
    member do
      get :thumbnail
      post :thumb_selected
    end
    collection do
      get :thumbnails
    end
  end

  match 'dropbox/authorize' => 'dropbox#authorize'
  match 'dropbox/upload' => 'dropbox#upload'
  match 'dropbox/import/:id' => 'dropbox#import'
  match 'dropbox/refresh/:id' => 'dropbox#refresh'
  match 'dropbox' => 'dropbox#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # See how all your routes lay out with "rake routes"

end
