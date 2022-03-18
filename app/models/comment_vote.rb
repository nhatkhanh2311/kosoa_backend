class CommentVote < ApplicationRecord
  belongs_to :user
  belongs_to :term_comment
end
