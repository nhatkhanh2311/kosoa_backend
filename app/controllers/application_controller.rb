class ApplicationController < ActionController::API
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

  def admin?
    logged_in?
    render status: :unauthorized unless @user.role.eql?("admin")
  end

  def teacher?
    logged_in?
    render status: :unauthorized unless @user.role.eql?("teacher")
  end

  def student?
    logged_in?
    render status: :unauthorized unless @user.role.eql?("student")
  end

  def teacher_or_student?
    logged_in?
    render status: :unauthorized unless @user.role.eql?("teacher") || @user.role.eql?("student")
  end

  def check_personal(id)
    if token
      user_id = AuthenticationTokenService.decode(token)
      user_id == id
    else
      false
    end
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    false
  end

  def token
    request.headers[:Authorization].split(" ").last if request.headers[:Authorization].present?
  end
end
