Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    # Sign up
    post "sign-up", to: "users#create"
    # Sign in
    post "sign-in", to: "sessions#create"

    # Users
    post "users/choose-level", to: "users#choose_level"
    post "users/avatar", to: "users#avatar"
    get "users/personal", to: "users#personal"
    post "users/show", to: "users#show"

    # System Terms
    post "terms/index", to: "system_terms#index"
    post "terms/show", to: "system_terms#show"
    post "terms/create", to: "system_terms#create"
    post "terms/update", to: "system_terms#update"
    post "terms/destroy", to: "system_terms#destroy"

    # Term Comments
    post "term/comments/index", to: "term_comments#index"
    post "term/comments/create", to: "term_comments#create"

    # Classes
    get "classes/index", to: "courses#index"
    post "classes/show", to: "courses#show"
    post "classes/create", to: "courses#create"
    post "classes/avatar", to: "courses#avatar"

    # Members
    post "members/accepted", to: "members#index_accepted"
    post "members/requested", to: "members#index_requested"
    post "members/create", to: "members#create"
    post "members/destroy", to: "members#destroy"
    post "members/accept", to: "members#accept"
    post "members/reject", to: "members#reject"
    post "members/check", to: "members#check_joined"

    # Notices
    post "notices/index", to: "notices#index"
    post "notices/create", to: "notices#create"

    # Search
    post "search/teacher", to: "users#search_teacher"
    post "search/student", to: "users#search_student"
    post "search/class", to: "courses#search"
    post "search/term", to: "system_terms#search"
  end
end
