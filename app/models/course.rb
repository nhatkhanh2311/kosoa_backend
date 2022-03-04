class Course < ApplicationRecord
  has_one_attached :avatar

  has_many :members, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :course_sets, dependent: :destroy

  belongs_to :user
end
