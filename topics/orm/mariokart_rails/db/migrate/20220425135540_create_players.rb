class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :email
      t.belongs_to :character, null: false, foreign_key: true
      t.belongs_to :race, null: true, foreign_key: true

      t.timestamps
    end
  end
end
