require 'rails_helper'

RSpec.describe "Login", type: :request do
  describe "POST /login" do
    it "with valid email, password must reponse token" do
      # byebug
      user = FactoryGirl.create(:user)

      post api_v1_auth_login_path,
        params: { auth: { email: user.email, password: user.password}}

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq({ 'token' => User.find(user.id).token })
    end

    it "with invalid email, password must response error 401 and error message" do
      post api_v1_auth_login_path,
        params: { auth: { email: '123', password: '123' }}

      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)).to eq({ 'errors' => 'Wrong email or password'})
    end

    it "with wrong params must response 422 and error message" do
      post api_v1_auth_login_path

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq({ 'errors' => 'Required parameters are missing'})
    end
  end
end
