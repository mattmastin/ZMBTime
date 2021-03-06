ZmbTimeSystem::Application.routes.draw do

  get "employees/new"

  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "log_out" => "sessions#destroy", :as => "log_out"

  get "users/change_password" => "users#change_password"
  match "users/show/:id" => "users#show"
  match "users/delete/:id" => "users#delete"

  get "/employees/update_info" => "employees#update_info"

  match "employees/show/:id" => "employees#show"
  match "employees/delete/:id" => "employees#delete"
  match "project_infos/show/:id" => "project_infos#show"
  match "project_infos/delete/:id" => "project_infos#delete"
  
  match "submit_hours/:project_id" => "submit_hours#index"

  post "users/change_password" => "users#update_password"
  root :to => "sessions#new"
  
  resources :submit_hours
  resources :users
  resources :sessions
  resources :admin_homes
  resources :employee_homes
  resources :employees
  resources :project_infos
  resources :hours_reports
  resources :directorys
  resources :expense_reports
  resources :hours_summaries
  resources :send_hours

  # match '*a' => "errors#routing"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
