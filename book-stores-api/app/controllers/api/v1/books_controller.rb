class Api::V1::BooksController < Api::V1::APIController
  before_action :authenticate_user

  def index
    render json: Book.all, status: :ok
  end
end
