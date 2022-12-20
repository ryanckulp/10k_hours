class PostsController < ApplicationController
  include ActiveStorage::SetCurrent
  include Pagy::Backend

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :show, :destroy]
  before_action :filter_posts, only: [:index]

  def index
    @featured_posts = Post.featured
    @pagy, @posts = pagy(@filtered_posts)
  end

  def new
    @post = current_user.posts.new
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post.slug), notice: 'Post updated'
  end

  def create
    post = current_user.posts.create!(post_params)
    redirect_to post_path(post.slug), notice: 'Post created'
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to dashboard_index_path, notice: 'Post deleted'
  end

  private

  def set_post
    @post = Post.find_by(slug: params[:id])
    @post = Post.find_by(id: params[:id]) if @post.nil?

    redirect_to root_path, error: 'Post not found' if @post.nil?
  end

  # improves UI when many recurring tasks exist sequentially without a regular update
  def filter_posts
    post_ids = []
    Post.published.newest_to_oldest.each_with_index do |post, idx|
      post_ids << post.id unless posts[idx - 1].recurring_id?
    end

    @filtered_posts = Post.where(id: post_ids)
  end

  def post_params
    params.require(:post).permit(:title, :meta_description, :content, :dollars, :hours, :visibility, :published_at, :featured, :recurring, :recurring_rule)
  end
end
