# player.rb
class Player < ApplicationRecord
  has_one :game, foreign_key: :creator_id
  has_and_belongs_to_many :joined_games, class_name: 'Game', join_table: 'games_players'
  has_one :chip  # Dodajte relaciju sa modelom Chip
  
  # Validations
  validates :email, presence: true, uniqueness: true

  def active_game?
    game&.active?
  end
end
