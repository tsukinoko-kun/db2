class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :speed
      t.integer :traction

      t.timestamps
    end
  end
end
