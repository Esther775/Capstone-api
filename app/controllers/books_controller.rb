class BooksController < ApplicationController
  def index
    @books = Book.all
    render template: "books/index"
  end
end
