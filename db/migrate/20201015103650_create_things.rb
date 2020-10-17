class CreateThings < ActiveRecord::Migration[6.0]
  def change
    create_table :things do |t|

      t.string :thing_name,     null: false
      t.integer :spoon
      t.integer :unit

      t.timestamps
    end
  end
end