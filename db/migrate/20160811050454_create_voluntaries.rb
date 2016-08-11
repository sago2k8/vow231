class CreateVoluntaries < ActiveRecord::Migration[5.0]
  def change
    create_table :voluntaries do |t|
      t.integer :user_id
      t.string :name
      t.string :photo_url

      t.timestamps
    end
  end
end
