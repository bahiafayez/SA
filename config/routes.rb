SA::Application.routes.draw do

  #resources :targets

  #resources :synonyms

  #resources :keywords

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "charts/index"
  match "/charts/sentiment" => "charts#sentiment"
  match "/charts/allcharts" => "charts#allcharts"
  match "/charts/mentions" => "charts#mentions"
  match "/charts/sentiments" => "charts#sentiments"
  match "/charts/check" => "charts#check"
  

  match "/articles/get_count" => "articles#get_count"
  match "/articles/get_mentions" => "articles#get_mentions"
  match "/articles/get_text" => "articles#get_text"
  match "/articles/getSelected" => "articles#getSelected"
  #get "home/index"

  #resources :comments

  # resources :articles do
    # collection do
      # get 'get_count'
      # get 'get_mentions'
    # end
  # end

  #resources :sources

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
