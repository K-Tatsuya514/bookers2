class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new
  end
  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  	  redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user.id != current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end

  protected
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
