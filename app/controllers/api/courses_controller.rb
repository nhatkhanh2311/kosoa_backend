class Api::CoursesController < ApplicationController
  before_action :teacher?, only: %i[index create avatar]
  before_action :student?, only: %i[joined]

  def index
    courses = @user.courses
    render json: { courses: courses_to_json(courses) }, status: :ok
  end

  def index_user
    courses = Course.where(user_id: params.require(:id))
    render json: { courses: courses_to_json(courses) }, status: :ok
  end

  def show
    course = Course.find(params.require(:id))
    render json: { course: course_to_json(course) }, status: :ok
  end

  def create
    course = @user.courses.build(course_params)
    if course.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def update
    course = Course.find(params.require(:id))
    if course.update(course_params)
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def avatar
    course = Course.find(params.require(:id))
    course.avatar.purge if course.avatar.attached?
    if course.avatar.attach(params.require(:avatar))
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def search
    courses = Course.where("LOWER(name) LIKE LOWER('%#{search_params}%')")
    render json: { results: courses_to_json(courses) }, status: :ok
  end

  def joined
    courses = Course.where("id IN (SELECT course_id FROM members WHERE user_id = #{@user.id})")
    render json: { courses: courses_to_json(courses) }, status: :ok
  end

  def joined_user
    courses = Course.where("id IN (SELECT course_id FROM members WHERE user_id = #{params.require(:id)})")
    render json: { courses: courses_to_json(courses) }, status: :ok
  end

  private

  def search_params
    params.require(:search)
  end

  def course_params
    params.require(:course).permit(:name, :description)
  end

  def courses_to_json(courses)
    courses.map { |course| course_to_json(course) }
  end

  def course_to_json(course)
    {
      id: course.id,
      name: course.name,
      description: course.description,
      avatar: course.avatar.url,
      members: course.members.where(accepted: true).count
    }
  end
end
