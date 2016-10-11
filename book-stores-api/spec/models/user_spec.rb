require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:password_digest) }

  describe "self.validate" do
    it "should return the found user when email and password is valid" do
      email = 'sample@mail.vn'
      password = '12345678'

      user = FactoryGirl.create(:user, email: email, password: password)
      found_user = User.authenticate(email: email, password: password)

      expect(found_user).not_to be_nil
      expect(found_user).to eq(user)
    end

    it "should return nil if email and password is invalid" do
      user = User.authenticate(email: 'faked@mail.vn', password: '12345678')

      expect(user).to be_nil
    end
  end

  describe "refresh_token" do
    it "should set a new unique token and return the updated user" do
      user = FactoryGirl.create(:user)
      old_token = user.token
      updated_user = user.refresh_token!

      expect(updated_user.token).not_to eq(old_token)
    end
  end

  describe "generate_new_token" do
    it "should return a new unique token and set user to new token but not update the database" do
      user = FactoryGirl.create(:user)
      old_token = user.token
      user.send(:generate_new_token)

      expect(user.token).not_to eq(old_token)
    end
  end

  describe "callbacks" do
    it "should generate new token before user is created" do
      users_num = User.count
      user = FactoryGirl.create(:user)

      expect(User.count).to eq(users_num + 1)
      expect(user.token).not_to be_nil
    end
  end
end
