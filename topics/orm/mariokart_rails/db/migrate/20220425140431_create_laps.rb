class CreateLaps < ActiveRecord::Migration[7.0]
  def change
    create_table :laps do |t|
      t.integer :duration
      t.belongs_to :player, null: false, foreign_key: true
      t.belongs_to :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
