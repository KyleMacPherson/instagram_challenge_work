class CommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to posts_path
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:notice] = 'Cannot delete another users post'
    end
    redirect_to '/posts'
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
