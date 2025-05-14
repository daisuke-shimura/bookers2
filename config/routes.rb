Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get 'home/about' => "homes#about"
  #get '/users'=> "users#index"
  resources :users, only: [:show,:index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "follower" => "relationships#follower", as: "follwer"
    get "followed" => "relationships#followed", as: "follwed"
  end

  resources :books, only: [:new, :index, :show, :edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end

  resources :groups, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new_mail" => "groups#new_mail", as: "new_mail"
    get "send_mail" => "groups#send_mail", as: "send_mail"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
