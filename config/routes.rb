Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :listings, only: [ :index, :show, :create, :update, :destroy ]
      resources :missions, only: [ :index ]
    end
  end
end
