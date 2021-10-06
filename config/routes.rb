Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
    # フォロー中のユーザとフォローされているユーザ一覧を表示するページ作成
  resources :users, only: [:index, :show, :create] do
    member do # idが含まれるURLの生成（ユーザの特定が必要）
      get :followings
      get :followers
      get :likes
    end
  end
  
  
  # お気に入り登録しているMicropostを一覧表示するページ作成
  get "signup", to: "user#new"
    
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy] # フォロー/アンフォローできるようにするルーティング
  resources :favorites, only: [:create, :destroy] # Micropostをお気に入りできるようにするルーティング
end