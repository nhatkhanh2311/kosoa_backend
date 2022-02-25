class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
