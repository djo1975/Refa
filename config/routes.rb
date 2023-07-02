Rails.application.routes.draw do
  put '/games/:id', to: 'games#update'
  get 'games/:id/play', to: 'plays#play', as: 'play_game'
  resources :games
  resources :players
end
