Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  devise_for :users
  get "home/about" => "homes#about", as: "about"
  resources :groups, except: [:destroy]
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]  do
   resources :book_comments, only: [:create, :destroy]
   resource  :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
   get "search", to: "users#search"
   resources :groups
    get "join" => "groups#join"
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  	get "daily_posts" => "users#daily_posts"
  end
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   get '/search', to: 'searchs#search'
    resources :chats, only: [:show, :create]
 end
