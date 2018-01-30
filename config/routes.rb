Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  namespace :admin do
    resources :restaurants
    resources :categories   # 請加入此行
    root "restaurants#index"
  end

  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]

    resources :users, only: [:show, :edit, :update]
    
    # 瀏覽所有餐廳的最新動態
    collection do
      get :feeds
    end

    # 瀏覽個別餐廳的 Dashboard
    member do
      get :dashboard
      post :favorite
      post :unfavorite
    end
  end
  
  resources :categories, only: :show

  
end
