module PostsHelper
  include Pagy::Frontend

  def single_post?
    params[:action] == 'show'
  end
end
