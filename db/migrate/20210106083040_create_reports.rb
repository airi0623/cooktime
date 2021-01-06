class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.references :user, type: :bigint, foreign_key: true
      t.references :recipe, type: :bigint, foreign_key: true
      t.string :repo, null: false
      t.string :repo_image, null: false
      t.timestamps
    end
  end
end
