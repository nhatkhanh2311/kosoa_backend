class SystemTerm < ApplicationRecord
  validates :term, uniqueness: { scope: :level }
end
