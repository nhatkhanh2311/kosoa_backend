class Api::UsersController < ApplicationController
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
end
