Rails.application.routes.draw do
  resources :events, only: [:index, :show]
  post '/vote/:id', to: 'events#vote', as: 'vote'
  get '/reveal/:id', to: 'events#reveal', as: 'reveal'
  root to: 'events#index'
  get '*path' => redirect('/')
end
