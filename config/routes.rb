Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create] do
    # ログインユーザがユーザをフォローできる設定およびフォロー中のユーザとフォローされているユーザ一覧を表示するページ作成
    member do
      get :followings
      get :followers
    end
    collection do
      get :search
    end
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end