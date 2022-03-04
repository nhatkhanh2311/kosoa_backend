class CourseSet < ApplicationRecord
  has_many :course_terms, dependent: :destroy

  belongs_to :course
end
