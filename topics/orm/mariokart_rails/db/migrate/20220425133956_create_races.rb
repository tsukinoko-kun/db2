class CreateRaces < ActiveRecord::Migration[7.0]
  def change
    create_table :races do |t|
      t.timestamp :started_at
      t.timestamp :finished_at
      t.belongs_to :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
