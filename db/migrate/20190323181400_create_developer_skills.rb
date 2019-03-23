class CreateDeveloperSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :developer_skills do |t|
      t.integer :position
      t.references :developer, foreign_key: true
      t.references :skill, foreign_key: true

      t.timestamps
    end
  end
end
