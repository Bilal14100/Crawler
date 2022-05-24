module LoginDocs
  extend Apipie::DSL::Concern
  def_param_group :success do
    property :token, String, desc: "JWT token"
  end
  error 422, "Invalid credentials", meta:{
    error: "Invalid username or password",
  }
  api :POST, "/login", "To get JWT token which will be used in Authorization header for all further requests"
  param :username, String, "username of the user", required: true
  param :password, String, "password of the user", required: true
  returns :success, "found the user against credentials"
  def create
    super
  end

end