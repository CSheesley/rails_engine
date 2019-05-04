Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'merchant/show'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'customer/show'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'items/index'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'invoice_items/index'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get 'transactions/index'
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :items do
        get 'best_day/show'
      end
    end
  end
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
        get "/:id/favorite_merchant", to: 'favorite_merchant#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get "/find", to: 'search#show'
        get "/find_all", to: 'search#index'
        get "/random", to: 'random#show'
        get "/:id/transactions", to: 'transactions#index'
        get "/:id/invoice_items", to: 'invoice_items#index'
        get "/:id/items", to: 'items#index'
        get "/:id/customer", to: 'customer#show'
        get "/:id/merchant", to: 'merchant#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get "/most_revenue", to: 'most_revenue#index'
        get "/most_items", to: 'most_items#index'
        get "/:id/best_day", to: 'best_day#show'
      end

    end
  end



end
