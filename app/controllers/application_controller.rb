class ApplicationController < ActionController::API
  before_action :logged_in?, only: %i[admin? teacher? student?]

  def logged_in?
    if token
      user_id = AuthenticationTokenService.decode(token)
      @user = User.find(user_id)
    else
      render status: :unauthorized
    end
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render status: :unauthorized
  end

  def role
    user_id = AuthenticationTokenService.decode(token)
    @user = User.find(user_id)
    @user[:role]
  end

  def admin?
    render status: :unauthorized unless role.eql?("admin")
  end

  def teacher?
    render status: :unauthorized unless role.eql?("teacher")
  end

  def student?
    render status: :unauthorized unless role.eql?("student")
  end

  def token
    request.headers[:Authorization].split(" ").last if request.headers[:Authorization].present?
  end
end
