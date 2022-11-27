class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show]

  def index
    @posts = Post.recent
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to @post
  end

  def create
    post = Post.create!(post_params)
    redirect_to post
  end

  def show
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :dollars, :hours)
  end
end
