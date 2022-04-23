Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  # 名前付きルートとは、文字通りルーティング自体に名前をつけておくこと
  #as:オプションを追加することで設定ができる
  #ここでは、「'lists#show'の設定を、listとして利用できる」の意味（asは、英語で「～として」の意味）。
  get 'homes/about' => 'homes#about',as:'about'

  end
