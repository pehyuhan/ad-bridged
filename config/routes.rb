Rails.application.routes.draw do
  
scope ":locale", locale: /#{I18n.available_locales.join("|")}/  do
    
    resources :posts
    get 'tags/:tag', to: 'posts#index', as: "tag"
    root to: redirect("/%{locale}/posts", status: 302)
    
    resources :users
    
    match '/sign_up',  to: 'users#new',            via: 'get'

    resources :sessions, only: [:new, :create, :destroy]
    #root  'static_pages#home'
    
    get    'sign_in'   => 'sessions#new'
    post   'sign_in'   => 'sessions#create'
    delete 'sign_out'  => 'sessions#destroy'
    
end

    root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root
    get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false
 
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
