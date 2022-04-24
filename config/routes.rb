Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  # 名前付きルートとは、文字通りルーティング自体に名前をつけておくこと
  #as:オプションを追加することで設定ができる
  #ここでは、「'lists#show'の設定を、listとして利用できる」の意味（asは、英語で「～として」の意味）。
  get 'homes/about' => 'homes#about',as:'about'

  resources :post_images, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :update]

  end