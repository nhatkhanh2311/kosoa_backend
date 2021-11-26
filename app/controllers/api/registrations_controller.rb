class Api::RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: { success?: true }, status: :created
    elsif user.errors[:username].include?("has already been taken")
      render json: { success?: false, message: "username taken" }, status: :unprocessable_entity
    elsif user.errors[:email].include?("has already been taken")
      render json: { success?: false, message: "email taken" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email, :birthday, :phone, :role)
  end
end
