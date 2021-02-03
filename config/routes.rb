Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    # devise_scope :user do
    #   post "/auth/register" => "registrations#create"
    #   post "/auth/login" => "sessions#create"
    # end
    devise_for :users,
               :path => "auth",
               :path_names => {
                  :sign_in => 'login',
                  :registration => 'register' 
               },
               components: {
                 sessions: 'sessions',
                 registrations: 'registrations'
               }
    resources :timesheets, only: [:index, :create, :show, :update, :destroy]
    resource :invoice, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
