class Api::TermCommentsController < ApplicationController
  before_action :teacher_or_student?, only: %i[index create]

  def index
    comments = TermComment.where(system_term_id: params.require(:id))
    render json: { comments: comments_to_json(comments) }, status: :ok
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
    comments.map { |comment| comment_to_json(comment) }
  end

  def comment_to_json(comment)
    user = User.find(comment.user_id)
    {
      id: comment.id,
      content: comment.content,
      created_at: comment.created_at,
      user_id: user.id,
      name: user.name,
      avatar: user.avatar.url
    }
  end
end
