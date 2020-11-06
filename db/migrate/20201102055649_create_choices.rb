class CreateChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :choices do |t|
      t.references :user   
      t.references :recipe
      t.timestamps
    end
  end
end
