class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.bigint :recipe_id, type: :bigint, foreign_key: true
      t.references :thing, type: :bigint, foreign_key: true
      t.string :name, null: false
      t.decimal :amount, precision: 6, scale: 2, null: false
      t.timestamps
    end
    
  end
end