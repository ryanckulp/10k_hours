Rails.application.routes.draw do
  root 'posts#index'

  resources :dashboard, only: [:index]
  resources :posts
  get 'settings', to: 'settings#edit', as: 'settings'
  resources :projects, only: [:update]
  get 'rss', to: 'rss#index', format: 'xml', as: :feed

  devise_for :users
  get 'logout', to: 'pages#logout', as: 'logout'

  # static pages
  pages = %w(
    privacy terms
  )

  pages.each do |page|
    get "/#{page}", to: "pages##{page}", as: "#{page.gsub('-', '_')}"
  end
end
