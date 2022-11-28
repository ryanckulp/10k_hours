class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :show]

  def index
    @posts = Post.recent
    @pagy, @posts = pagy(Post.recent)
  end

  def new
    @post = current_user.posts.new
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post.slug)
  end

  def create
    post = current_user.posts.create!(post_params)
    redirect_to post_path(post.slug)
  end

  def show
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
    @post = Post.find_by(id: params[:id]) if @post.nil?

    redirect_to root_path, error: 'Post not found' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content, :dollars, :hours)
  end
end
