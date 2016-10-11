require 'bookstore_api/client'

class BooksController < ApplicationController
  def index
    client = ::BookStoreAPI::Client.new('hatu87@gmail.com', '12345678')
    client.login
    @books = client.books
  end
end
