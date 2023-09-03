class CreateAuctions < ActiveRecord::Migration[7.0]
  def change
    create_table :auctions do |t|
      t.integer :game_id
      t.integer :current_player_id
      t.boolean :is_active, default: true
      t.json :ready_players, default: []

      t.timestamps
    end
  end
end
