Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post "/login", to: "login#create"
      resources :products, only: :index
      resources :amazon_serps, expect: [:edit, :new]
    end
  end
end
