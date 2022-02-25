class Api::NoticesController < ApplicationController
  before_action :teacher_or_student?, only: %i[index]
  before_action :teacher?, only: %i[create]

  def index
    notices = Notice.where(course_id: params.require(:id)).order(created_at: :desc)
    render json: { notices: notices_to_json(notices) }, status: :ok
  end

  def create
    notice = Notice.new(notice_params)
    if notice.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  private

  def notice_params
    params.require(:notice).permit(:content, :course_id)
  end

  def notices_to_json(notices)
    notices.map { |notice| notice_to_json(notice) }
  end

  def notice_to_json(notice)
    {
      id: notice.id,
      content: notice.content,
      created_at: notice.created_at
    }
  end
end
