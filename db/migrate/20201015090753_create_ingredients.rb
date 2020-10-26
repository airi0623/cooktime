class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe,      null: false
      t.references :thing,       null: false
      t.integer :amount,         null: false

      t.timestamps
    end
  end
end
