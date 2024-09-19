Rails.application.routes.draw do
  # CORS options request
  match "*path" => "application#options", via: :options

  # root path route ("/")
  root "posts#index"

  # resources
  resources :posts
  resources :users do
    member do
      get "posts"
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
