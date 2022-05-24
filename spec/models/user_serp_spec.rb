require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    let(:valid_user){FactoryBot.build(:user)}
    let(:invalid_user){FactoryBot.build(:user, password: nil)}
    context "Invalid" do
      
      it "should not be valid with duplicate username and null password" do
        valid_user.save
        invalid_user.username = valid_user.username
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors.messages).to eq({:password=>["can't be blank"], :username=>["has already been taken"]})
      end
    end

    context "valid user" do
      it "should be a valid user with unique username and not null password" do
        expect(valid_user).to be_valid
      end
    end
  end
end
