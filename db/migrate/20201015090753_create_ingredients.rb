class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe, type: :bigint, foreign_key: true
      t.integer :thing_id, null: false
      t.decimal :amount, precision: 6, scale: 2, null: false
      t.timestamps
    end
    
  end
end
