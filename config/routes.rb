Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      # only read

      # read / write

      # special
      # devise_for :users, controllers: { sessions: 'api/v1/sessions'}, only: 'sessions'
      devise_scope :user do
        get '/password/edit' => 'fm_passwords#edit', as: 'edit_password'
        post '/password' => 'fm_passwords#create'
        put '/password' => 'fm_passwords#update'
        put '/users' => 'fm_registrations#update'
      end

      get '/jwt_token' => 'fm_jwt_token#show'
      post '/jwt_token' => 'fm_jwt_token#create'
      delete '/jwt_token' => 'fm_jwt_token#destroy'
      get 'api_authenticated_nothing' => 'fm_base#authenticated_nothing'
    end
  end

  # admin
  namespace :admin do
    resources :quizzes
    resources :categories
    resources :information_types
    resources :answers
    resources :informations
    resources :quiz_informations
    resources :memes
    resources :users

    # special
    get 'admin_authenticated_nothing' => 'fm_base#admin_authenticated_nothing'
    get '/' => 'fm_base#admin_authenticated_nothing', as: 'root'
  end

  authenticate :user, lambda {|u| u.admin? || u.super_admin? } do
    apipie
  end

  devise_for :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  unless Rails.env.test?
    get '*unmatched_route', :to => 'application#raise_not_found!'
  end

  root 'application#nothing'


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
