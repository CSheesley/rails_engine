Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: 'search#show'
        get "/find_all", to: 'search#index'
        get "/random", to: 'random#show'
        get "/most_revenue", to: 'most_revenue#index'
        get "/most_items", to: 'most_items#index'
        get "/revenue", to: 'revenue#index'
        get "/:id/revenue", to: 'revenue#show'
        get "/:id/items", to: 'items#index'
        get "/:id/invoices", to: 'invoices#index'
        get "/:id/favorite_customer", to: 'favorite_customer#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get "/find", to: 'search#show'
        get "/find_all", to: 'search#index'
        get "/random", to: 'random#show'
       # fav merchant
      end
      resources :customers, only: [:index, :show]
    end
  end



end
