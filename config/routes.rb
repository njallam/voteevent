Rails.application.routes.draw do
  resources :events, only: [:index, :show]
  post '/vote/:id', to: 'events#vote', as: 'vote'
  root to: 'events#index'
end
