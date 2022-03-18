class AddIndexCourseTerms < ActiveRecord::Migration[6.1]
  def change
    add_index :course_terms, %i[term course_set_id]
  end
end
