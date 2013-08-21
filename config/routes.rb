Care247::Application.routes.draw do

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
    resources :requests, only: [:show, :update, :destroy]


    get "static_pages/home"
    get "/pricing", to: "static_pages#pricing"
    get "/about", to: "static_pages#about"
    get "/signin", to: "sessions#new"
    get "/edit_desk/:id", to: "desks#edit", as: :edit_desk

    match "/signout", to: "sessions#destroy", via: :delete
end