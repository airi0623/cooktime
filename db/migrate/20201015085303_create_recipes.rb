class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user,      null: false
      t.string :title,         null: false
      t.string :feature
      t.string :eat,           null: false
      t.integer :category_id,  null: false
      t.integer :cold_date
      t.integer :frozen_date
      t.integer :time,         null: false
      t.string :cook,          null: false

      t.timestamps
    end
  end
end