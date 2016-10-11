# require 'rest-client'

module BookStoreAPI
  class Client
    BOOKSTORE_API_HOST = 'http://localhost:3001/api/v1'

    def initialize(email, password)
      @email = email
      @password = password
    end

    def books_path
      "#{BOOKSTORE_API_HOST}/books"
    end

    def token_authorized?
      @access_token.present?
    end

    def request(params)
      request_params = params
      if token_authorized?
        request_params = request_params.merge({ headers: { Authorization: "Token token=#{@access_token}" }})
      end

      RestClient::Request.execute(request_params)
    end

    def get(url, params={})
      request(method: :get, url: url, payload: params)
    end

    def post(url, params={})
      request(method: :post, url: url, payload: params)
    end

    def login_path
      "#{BOOKSTORE_API_HOST}/auth/login"
    end

    def login
      response = post login_path, { auth: { email: @email, password: @password }}
      @access_token = JSON.parse(response.body)['token']
    end

    def books
      response = get books_path

      if response.code == 200
        JSON.parse(response.body)
      else
        []
      end
    end
  end
end
