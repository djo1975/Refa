class Game < ApplicationRecord
  belongs_to :creator, class_name: 'Player'
  has_and_belongs_to_many :players, join_table: 'games_players'

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
