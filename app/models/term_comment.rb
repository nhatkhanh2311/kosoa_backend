class TermComment < ApplicationRecord
  belongs_to :user
  belongs_to :system_term
end
