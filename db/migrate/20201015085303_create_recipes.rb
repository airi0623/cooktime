class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.references :user,      foreign_key: true
      t.string :title,         null: false
      t.string :feature #,       null: false
      t.string :eat,           null: false
      t.integer :category_id,  null: false
      t.integer :cold_date #,       null: false
      t.integer :frozen_date #,       null: false
      t.integer :time,         null: false
      t.string :text,          null: false

      t.timestamps
    end
  end
end