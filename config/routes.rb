Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Sign up
    post "sign-up", to: "users#create"
    # Sign in
    post "sign-in", to: "sessions#create"

    namespace :admin do
      # System Terms
      post "terms/index", to: "system_terms#index"
      post "terms/create", to: "system_terms#create"
      post "terms/destroy", to: "system_terms#destroy"
    end
  end
end
