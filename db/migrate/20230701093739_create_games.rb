class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.integer :creator_id
      t.integer :player2_id
      t.integer :player3_id
      t.string :status
      t.integer :duration
      t.integer :buli
      t.integer :ref_count

      t.timestamps
    end
  end
end
