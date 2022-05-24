module JsonWebToken
  require 'jwt'
  JWT_SECRET = Rails.application.credentials.config[:api_secret]

  def self.issue_jwt(user_id)
    exp = 24.hours.from_now
    payload = { "iss": "medical_screening_app",
      "exp": exp.to_i,
      "sub": "user",
      "user_id": user_id,
    }

    JWT.encode payload,JWT_SECRET , 'HS256'
  end

  def self.authenticate(request)
    token = request.headers["AUTHORIZATION"]
    if !token || !valid_token(token)
      return false
    else
      return true
    end
  end

  def self.valid_token(token)
    unless token
      return false
    end
    token.gsub!('Bearer ','')
    begin
      decoded_token = JWT.decode token, JWT_SECRET , true
    rescue JWT::DecodeError
      return false
    else
      return true
    end
  end

  def self.logged_in_user(request)
    token = request.headers["AUTHORIZATION"]
    token.gsub!('Bearer ','')
    decoded_token = JWT.decode token, JWT_SECRET , true
    user_id = decoded_token[0]['user_id']
    if decoded_token
      user = User.find_by(id: user_id)
    end
    user.nil? ? false : user
  end
end