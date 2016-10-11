class Api::V1::AuthController < Api::V1::APIController

  def login
    # byebug
    begin
      user = User.authenticate(auth_params)
      # byebug
      unless user.nil?
        render json: { token: user.token }, status: :ok
      else
        render json: { errors: 'Wrong email or password' }, status: :unauthorized
      end
    rescue ActionController::ParameterMissing
      render json: { errors: 'Required parameters are missing'}, status: :unprocessable_entity
    end

  end

  private
  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
