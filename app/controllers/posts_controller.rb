class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.user_id = current_user.id
      @post.email = current_user.email
      @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
      flash[:notice] = 'Post edited successfully'
    else
      flash[:notice] = 'Cannot edit another users post'
    end
    redirect_to '/posts'
  end

  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
      flash[:notice] = 'Post deleted successfully'
    else
      flash[:notice] = 'Cannot delete another users post'
    end
    redirect_to '/posts'
  end


private

  def post_params
    params.require(:post).permit(:content, :image)
  end


end
