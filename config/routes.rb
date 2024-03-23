#routes.rb

Rails.application.routes.draw do
  # お問い合わせフォーム用のルーティング
  resources :contacts, only: [:new, :create]
  root to: "contacts#new"

  get 'contact_thank_you', to: 'contacts#thank_you'

  # get 'コントローラー/アクション', to: 'コントローラー＃アクション'

  # get 'posts', to: 'posts#index'
  # get 'posts/new', to: 'posts#new'
end
