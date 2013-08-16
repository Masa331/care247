Care247::Application.routes.draw do

    post '/email_processor' => 'EmailProcessor#process'

    get "desks/new"
    get "desks/create"
    get "desks/update"
    get "desks/destroy"
    get "desks/show"

    root to: "static_pages#home"
    resources :users do
        resources :desks, only: [:new, :create]
    end

    resources :desks, only: [:show, :update, :destroy]
    resources :sessions, only: [:new, :create, :destroy]


    get "static_pages/home"
    get "/pricing", to: "static_pages#pricing"
    get "/about", to: "static_pages#about"
    get "/signin", to: "sessions#new"

    match "/signout", to: "sessions#destroy", via: :delete
end