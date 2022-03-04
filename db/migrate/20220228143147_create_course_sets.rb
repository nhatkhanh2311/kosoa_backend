class CreateCourseSets < ActiveRecord::Migration[6.1]
  def change
    create_table :course_sets do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps

      t.references :course, foreign_key: true
    end
  end
end
