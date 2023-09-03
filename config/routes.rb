Rails.application.routes.draw do
  put '/games/:id', to: 'games#update'
  put '/games/:id/join/:player_id', to: 'games#join', as: 'join_game'
  get '/games/:id/play', to: 'games#play', as: 'play_game'
  delete '/games/:id/exit/:player_id', to: 'games#exit', as: 'exit_game'
  resources :chips, only: [] do
    member do
      post :add_chips
      post :remove_chips
      post :refund_chips
      get :show
    end
  end
  resources :games do
    resource :dealt_card, only: [:create, :destroy, :index]
    get 'dealt_card', to: 'dealt_cards#index'
    resources :auctions, only: [:create, :update, :destroy]
    get 'auctions', to: 'auctions#index'
  end
  
  resources :players do
    member do
      get :show
    end
  end
  
  mount ActionCable.server => '/cable'

  resources :chat_messages, only: [:create, :index]
end
