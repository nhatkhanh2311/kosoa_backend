Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Sign up
    post "sign_up", to: "registrations#create"
    # Log in
    post "log_in", to: "sessions#create"
  end
end
