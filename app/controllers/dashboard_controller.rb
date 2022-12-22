class DashboardController < ApplicationController
  include Pagy::Backend
  before_action :authenticate_user!

  def index
    @draft_posts = Post.draft.newest_to_oldest
    @published_pagy, @published_posts = pagy(Post.published.newest_to_oldest)
  end
end
