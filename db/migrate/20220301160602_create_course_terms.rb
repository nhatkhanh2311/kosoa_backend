class CreateCourseTerms < ActiveRecord::Migration[6.1]
  def change
    create_table :course_terms do |t|
      t.string :term, null: false
      t.string :pronunciation
      t.string :definition
      t.string :description
      t.string :example
      t.string :note
      t.timestamps

      t.references :course_set, foreign_key: true
    end
  end
end
