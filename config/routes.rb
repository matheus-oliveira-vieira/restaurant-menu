Rails.application.routes.draw do
  # get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
       post "/import", to: "imports#create"
      resources :restaurants, only: [ :index, :show ] do
        resources :menus, only: [ :index, :show ]
      end
    end
  end
end
