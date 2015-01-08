Rails.application.routes.draw do

  devise_for :users
  get '/' => 'pages#home'

  get 'pages/home'
  
  resources :products

  get 'products/:id/delete' => 'products#delete', :as => :products_delete

  post 'products/:id/add_to_cart' => 'products#add_to_cart', :as => :products_add_to_cart

  post 'products/:id/validate' => 'products#validate', :as => :products_validate

  get 'pages/calculator'

  resources :categories
  
  get 'categories/:id/delete' => 'categories#delete', :as => :categories_delete

  get 'categories/:id' => 'categories#show', :as => :categories_show

  resources :orders

  get 'orders/:id/cancel' => 'orders#cancel', :as => :orders_cancel

  get 'orders/:id/checkout' => 'orders#checkout', :as => :orders_checkout
  
  post 'orders/:id/validate' => 'orders#validate', :as => :orders_validate

  resources :line_items

  get 'line_items/:id/delete' => 'line_items#delete', :as => :line_items_delete
  
  post 'line_items/:id/update_quantity' => 'line_items#update_quantity', :as => :line_items_update_quantity

  # resources :line_items

  # get 'line_items/:id/delete' => 'line_items#delete', :as => :line_items_delete

  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
