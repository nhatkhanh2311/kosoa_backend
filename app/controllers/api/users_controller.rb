class Api::UsersController < ApplicationController
  before_action :teacher_or_student?, only: %i[avatar personal]
  before_action :student?, only: %i[choose_level]

  def create
    user = User.new(user_params)
    if user.save
      render status: :created
    elsif user.errors[:username].include?("has already been taken")
      render json: { message: "username taken" }, status: :unprocessable_entity
    elsif user.errors[:email].include?("has already been taken")
      render json: { message: "email taken" }, status: :unprocessable_entity
    end
  end

  def avatar
    @user.avatar.purge if @user.avatar.attached?
    if @user.avatar.attach(params.require(:avatar))
      render status: :created
    else
      render status: :unprocessable_entity
    end
  end

  def personal
    render json: { user: user_to_json(@user) }, status: :ok
  end

  def show
    user = User.find_by_username(params.require(:username))
    if user
      render json: { user: user_to_json(user) }, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def choose_level
    if @user.update(level: params.require(:level))
      render status: :accepted
    else
      render status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :email, :birthday, :phone, :role)
  end

  def user_to_json(user)
    {
      id: user.id,
      username: user.username,
      name: user.name,
      email: user.email,
      birthday: user.birthday,
      phone: user.phone,
      role: user.role,
      avatar: user.avatar.url
    }
  end
end
