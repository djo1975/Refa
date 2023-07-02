class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :picture
      t.string :email
      t.integer :infractions, default: 0
      t.integer :chips, default: 0
      t.integer :rating, default: 0

      t.timestamps
    end
  end
end
