class Api::V1::BooksController < Api::V1::ApiBaseController
  before_action :authorize_request

  def index
    @books = Book.all

    render 'api/v1/books/index.json.jbuilder'
  end

  def show
    @book = Book.find(params[:id] || params[:book_id])

    render 'api/v1/books/show.json.jbuilder'
  end

  def create
    @book = Book.create(book_params)

    render 'api/v1/books/show.json.jbuilder'
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :editor)
  end

end