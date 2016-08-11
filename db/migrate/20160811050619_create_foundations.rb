class CreateFoundations < ActiveRecord::Migration[5.0]
  def change
    create_table :foundations do |t|
      t.integer :user_id
      t.string :name
      t.string :photo_url
      t.string :description

      t.timestamps
    end
  end
end
