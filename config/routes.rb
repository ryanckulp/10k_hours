Rails.application.routes.draw do
  root 'posts#index'

  resources :dashboard, only: [:index]
  resources :posts, only: [:index, :new, :create, :show]

  devise_for :users
  get 'logout', to: 'pages#logout', as: 'logout'

  # static pages
  pages = %w(
    privacy terms
  )

  pages.each do |page|
    get "/#{page}", to: "pages##{page}", as: "#{page.gsub('-', '_')}"
  end

  # admin panels
  authenticated :user, -> user { user.admin? } do
    namespace :admin do
      resources :dashboard, only: [:index]
      resources :users, only: [:edit, :update, :destroy]
    end

    # convenience helper
    get 'admin', to: 'admin/dashboard#index'
  end
end
