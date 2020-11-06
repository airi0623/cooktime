class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.references :user,   foreign_key: true
      t.references :recipe, foreign_key: true
      t.timestamps
    end
  end
end
