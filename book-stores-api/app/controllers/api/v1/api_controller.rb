# Abstract Controller Class for API
# @author Tu Hoang
#
class Api::V1::APIController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # Parse user's token and return the user object
  #
  # @return [User] current logged user
  def current_user
    authenticate_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end

  # Authorize user before running to some protected controller's actions
  #
  def authenticate_user
    # byebug
     current_user || render_unauthorized
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized Access' }, status: :unauthorized
  end
end
