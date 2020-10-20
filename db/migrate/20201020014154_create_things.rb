class CreateThings < ActiveRecord::Migration[6.0]
  def change
    create_table :things do |t|

      t.string :thing_name,     null: false
      t.string :spoon
      t.string :unit

      t.timestamps
    end
  end
end