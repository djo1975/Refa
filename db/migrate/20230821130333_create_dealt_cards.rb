class CreateDealtCards < ActiveRecord::Migration[7.0]
  def change
    create_table :dealt_cards do |t|
      t.integer :game_id
      t.json :player1
      t.json :player2
      t.json :player3
      t.json :table

      t.timestamps
    end
  end
end
