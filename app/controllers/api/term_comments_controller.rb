class Api::TermCommentsController < ApplicationController
  before_action :teacher_or_student?, only: %i[index show create]

  def index
    comments = TermComment.where(system_term_id: params.require(:id))
    render json: { comments: comments_to_json(comments) }, status: :ok
  end

  def show
    comment = TermComment.find(params.require(:id))
    render json: { comment: comment_to_json(comment) }, status: :ok
  end

  def create
    comment = @user.term_comments.build(comment_params)
    if comment.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :system_term_id)
  end

  def comments_to_json(comments)
    results = comments.map { |comment| comment_to_json(comment) }
    results.sort_by { |r| [r[:bad_votes] - r[:good_votes], -r[:good_votes]] }
  end

  def comment_to_json(comment)
    user = User.find(comment.user_id)
    vote = comment.comment_votes.find_by(user_id: @user.id)
    {
      id: comment.id,
      content: comment.content,
      created_at: comment.created_at,
      user_id: user.id,
      name: user.name,
      avatar: user.avatar.url,
      good_votes: comment.comment_votes.where(kind: true).count,
      bad_votes: comment.comment_votes.where(kind: false).count,
      your_vote: if vote.nil?
                   nil
                 else
                   vote.kind
                 end
    }
  end
end
