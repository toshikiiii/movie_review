Rails.application.routes.draw do
  get  "up" => "rails/health#show", as: :rails_health_check
  root "movies#index"

  resources :movies, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:create, :edit, :update, :destroy]
    collection { get :search }
  end

  resources :genres

  # ユーザー登録 / 表示 / 編集
  resources :users, only: [:new, :create, :show, :edit, :update]

  # 本人用ショートカット
  get   "/account/edit", to: "users#edit",   as: :edit_account
  patch "/account",      to: "users#update", as: :account

  # セッション（ログイン/ログアウト）
  resource :session, only: [:new, :create, :destroy]
  get    "/signup", to: "users#new"
  get    "/login",  to: "sessions#new"
  delete "/logout", to: "sessions#destroy", as: :logout
end