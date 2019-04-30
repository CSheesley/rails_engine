Rails.application.routes.draw do

  # get "/api/v1/merchants/find", to: 'api/v1/merchants/search#show'
  # get "/api/v1/merchants/find_all", to: 'api/v1/merchants/search#index'

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "/find", to: 'search#show'
        get "/find_all", to: 'search#index'
      end
      resources :merchants, only: [:index, :show]
    end
  end

end
