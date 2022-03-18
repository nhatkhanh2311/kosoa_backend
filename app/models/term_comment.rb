class TermComment < ApplicationRecord
  has_many :comment_votes

  belongs_to :user
  belongs_to :system_term
end
