class BookCommentsController < ApplicationController
  def create
    @book=Book.find(params[:book_id])
    @book_comment=BookComment.new(book_comment_params)
    @book_comment.user_id=current_user.id
    @book_comment.book_id=@book.id
    respond_to do |format|
      if @book_comment.save
        format.js  # create.js.erbが呼び出される
      else
      end
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment=BookComment.find(params[:id]).destroy
    # @book_comment=BookComment.new(book_comment_params)
    #BookComment.find(params[:id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end

