class Api::CourseSetsController < ApplicationController
  before_action :teacher_or_student?, only: %i[index show]
  before_action :teacher?, only: %i[create destroy]

  def index
    sets = CourseSet.where(course_id: params.require(:id)).order(:id)
    render json: { sets: sets_to_json(sets) }, status: :ok
  end

  def show
    set = CourseSet.find(params.require(:id))
    render json: { set: set_to_json(set) }, status: :ok
  end

  def create
    set = CourseSet.new(set_params)
    if set.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    set = CourseSet.find(params.require(:id))
    if set.destroy
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  private

  def set_params
    params.require(:set).permit(:name, :description, :course_id)
  end

  def sets_to_json(sets)
    sets.map { |set| set_to_json(set) }
  end

  def set_to_json(set)
    {
      id: set.id,
      name: set.name,
      description: set.description
    }
  end
end
