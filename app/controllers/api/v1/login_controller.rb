class Api::V1::LoginController < ApiBaseController
  include LoginDocs
  skip_before_action :require_jwt
  
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      user.update_attribute(:last_login, Date.today)
      render json: {token: JsonWebToken.issue_jwt(user.id)}, status: 200
    else
      render json: {error: "Invalid username or password"}, status: 401
    end
  end

end
