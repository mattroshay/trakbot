class CreateTrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :trackers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :link
      t.string :description
      t.string :keywords

      t.timestamps
    end
  end
end
