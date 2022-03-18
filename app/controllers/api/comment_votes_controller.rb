class Api::CommentVotesController < ApplicationController
  before_action :teacher_or_student?, only: %i[create update destroy]

  def create
    vote = @user.comment_votes.build(kind: params.require(:kind), term_comment_id: params.require(:id))
    if vote.save
      render json: { votes: votes_to_json(params.require(:id)) }, status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def update
    vote = @user.comment_votes.find_by(term_comment_id: params.require(:id))
    if vote.update(kind: !vote.kind)
      render json: { votes: votes_to_json(params.require(:id)) }, status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    vote = @user.comment_votes.find_by(term_comment_id: params.require(:id))
    if vote.destroy
      render json: { votes: votes_to_json(params.require(:id)) }, status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  private

  def votes_to_json(id)
    comment = TermComment.find(id)
    {
      good_votes: comment.comment_votes.where(kind: true).count,
      bad_votes: comment.comment_votes.where(kind: false).count
    }
  end
end
