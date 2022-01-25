class SystemTerm < ApplicationRecord
  has_many :term_comments

  validates :term, uniqueness: { scope: :level }
end
