class Api::MembersController < ApplicationController
  before_action :teacher?, only: %i[index_accepted index_requested accept reject]
  before_action :student?, only: %i[create destroy check_joined]

  def index_accepted
    members = Member.where(accepted: true, course_id: params.require(:id))
    render json: { members: members_to_json(members) }, status: :ok
  end

  def index_requested
    members = Member.where(accepted: false, course_id: params.require(:id))
    render json: { members: members_to_json(members) }, status: :ok
  end

  def create
    member = @user.members.build(accepted: false, course_id: params.require(:id))
    if member.save
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    member = @user.members.find_by(course_id: params.require(:id))
    if member.destroy
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def accept
    member = Member.find(params.require(:id))
    if member.update(accepted: true)
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def reject
    member = Member.find(params.require(:id))
    if member.destroy
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  def check_joined
    member = @user.members.find_by(course_id: params.require(:id))
    if member.nil?
      render json: { message: "not request" }, status: :ok
    elsif member.accepted
      render json: { message: "accepted" }, status: :ok
    else
      render json: { message: "requested" }, status: :ok
    end
  end

  private

  def members_to_json(members)
    members.map { |member| member_to_json(member) }
  end

  def member_to_json(member)
    user = User.find(member.user_id)
    {
      id: member.id,
      userId: user.id,
      name: user.name,
      avatar: user.avatar.url
    }
  end
end
