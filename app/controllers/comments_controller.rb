class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!
  def create
    if user_signed_in?
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      @comment.save
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  def destroy
    if user_signed_in?
      @comment = @post.comments.find(params[:id])
      @comment_id = @comment.id
      @comment.destroy
    else
      redirect_to posts_path, notice: 'Signing in please'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
  def set_post
    @post = Post.find(params[:post_id])
  end
end
