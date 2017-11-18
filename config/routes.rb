Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'articles/manage', to: 'articles#manage'
  get 'dumped_links/reject', to: 'dumped_links#reject'
  get 'about', to: 'home#about', as: 'about'

  resources :sessions, only: %i[create destroy]
  resource :home, only: [:show]

  root to: 'home#show'

  get 'sandbox', to: 'home#sandbox'

  resources :articles
  resources :rss_feeds, only: %i[new create destroy]
  resources :dumped_links, only: %i[new create destroy reject]
end
