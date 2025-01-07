Rails.application.routes.draw do
  resources :posts do 
    post :like, on: :member
  end
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :profiles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  # Home routes
  get "home/", to: "home#index", as: "home_index"
  post "home/add_friend/:id", to: "home#add_friend", as: "home_add_friend"
  post "home/remove_friend/:id", to: "home#remove_friend", as: "home_remove_friend"

  # Authentication routes
  get "auth/login", to: "auth#login"
  post "auth/login", to: "auth#loginpost", as: "auth_loginpost"
  get "auth/logout", to: "auth#logout", as: "auth_logout"
  get "auth/signup", to: "auth#signup", as: "auth_signup"
  post "auth/signup", to: "auth#signuppost", as: "auth_signuppost"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
