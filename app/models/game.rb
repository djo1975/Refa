class Game < ApplicationRecord
  belongs_to :creator, class_name: 'Player'
  belongs_to :player2, class_name: 'Player', foreign_key: 'player2_id', optional: true
  belongs_to :player3, class_name: 'Player', foreign_key: 'player3_id', optional: true
  has_and_belongs_to_many :players, join_table: 'games_players'
  has_one :dealt_card, dependent: :destroy
  has_one :auction
  has_many :game_players
  has_many :players, through: :game_players
  # Validations
  validates :buli, presence: true, numericality: { greater_than: 0, message: 'must be greater than 0' }

  def pending?
    status == 'pending'
  end

  def active?
    status == 'active'
  end

  def full?
    creator_id.present? && player2_id.present? && player3_id.present?
  end
  
end
