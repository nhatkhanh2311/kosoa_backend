class CourseTerm < ApplicationRecord
  belongs_to :course_set

  validates :term, uniqueness: { scope: :course_set_id }
end
