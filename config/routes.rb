Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  namespace :api do
    namespace :v1 do
       post "/import", to: "imports#create"
      resources :restaurants, only: [ :index, :show, :create, :update ] do
        resources :menus, only: [ :index, :show, :create ] do
          resources :menu_items, only: [ :create ]
        end
      end

      resources :menus, only: [ :update ]
      resources :menu_items, only: [ :show, :update ]
    end
  end
end
