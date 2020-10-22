Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      #=== items
      get 'items/find_all', to: "items_search#index"
      get 'items/find', to: "items_search#show"
      get '/items/:id/merchant', to: 'merchant_items#show'
      resources :items

      #=== merchants
      get 'merchants/find_all', to: "merchant_search#index"
      get 'merchants/find', to: "merchant_search#show"
      get '/merchants/most_revenue', to: 'merchant_search#most_revenue'
      get '/merchants/most_items', to: 'merchant_search#most_items'
      get '/merchants/:id/items', to: 'merchant_items#index'
      resources :merchants
      
    end
  end
end

