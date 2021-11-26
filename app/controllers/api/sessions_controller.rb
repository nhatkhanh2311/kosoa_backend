class Api::SessionsController < ApplicationController
  def create
    if (user = User.find_by_username(params.require(:username)))
      if user.authenticate(params.require(:password))
        token = AuthenticationTokenService.encode(user.id)
        render json: { success?: true, token: token }, status: :created
      else
        render json: { success?: false, message: "wrong password" }, status: :unauthorized
      end
    else
      render json: { success?: false, message: "username not exist" }, status: :unauthorized
    end
  end
end
