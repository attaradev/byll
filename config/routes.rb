Rails.application.routes.draw do
  namespace :api do
    namespace :v1, default: {format: :json} do
      resources :timesheets, only: [:index, :create, :update, :destroy]
      resource :invoice, only: [:create]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
