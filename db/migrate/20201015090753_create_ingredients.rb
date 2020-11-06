class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.references :recipe,      foreign_key: true
      t.references :thing,       foreign_key: true
      t.integer :amount,         null: false

      t.timestamps
    end
  end
end
