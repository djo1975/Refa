# app/models/auction.rb

class Auction < ApplicationRecord
    belongs_to :game
    belongs_to :current_player, class_name: 'Player', foreign_key: 'current_player_id'
  
    validates :is_active, inclusion: { in: [true, false] }
  end
  