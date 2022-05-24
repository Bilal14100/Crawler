RSpec.shared_context 'user_jwt_token' do
  before(:all) do
    user = FactoryBot.create(:user)
    @token =  JsonWebToken.issue_jwt(user.id)
  end
end