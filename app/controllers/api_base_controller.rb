class ApiBaseController < ActionController::API
  before_action :require_jwt
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def require_jwt
    unless JsonWebToken.authenticate(request)
      render json: {error: "Invalid token"}, status: 403
    end
  end

  # TODO: Put this method in caching
  def current_user
    JsonWebToken.logged_in_user(request)
  end

  # TODO: Put this method in caching
  def current_user_roles
    user = current_user
    if user
      user = User.includes(:roles).where(id: user.id).pluck("roles.name")
    else
      false
    end
  end
  
  private
  
  def record_not_found
    render json: {error:  "Record not found"}, status: 404
  end
  
end