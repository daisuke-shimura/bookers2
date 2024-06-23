Rails.application.routes.draw do

  devise_for :users

  root to: 'homes#top'
  get 'home/about' => "homes#about"
  #get '/users'=> "users#index"
  resources :users, only: [:show,:index, :edit, :update ]

  resources :books, only: [:new, :index, :show, :edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
