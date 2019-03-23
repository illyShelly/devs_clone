class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name
      t.string :github_username
      t.string :avatar_url
      t.text :bio
      t.integer :hourly_rate
      t.integer :bookings_count
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
