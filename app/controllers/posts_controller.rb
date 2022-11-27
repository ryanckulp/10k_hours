class PostsController < ApplicationController
  def index
    @posts = Post.recent
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create!(post_params)
    redirect_to post
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
