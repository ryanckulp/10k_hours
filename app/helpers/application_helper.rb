module ApplicationHelper
  def project_start_date
    Post.first.created_at.strftime('%B %d, %Y')
  rescue
    Date.today.strftime('%B %d, %Y')
  end

  def default_user
    User.default_user
  end

  def follow_me_link
    default_user.follow_me_link
  end

  def project_name
    default_user.project_name
  end

  def project_description
    default_user.project_description.html_safe
  end

  def project_bio
    default_user.bio.html_safe
  end

  def project_progress_percentage
    (Post.hours_spent.round(1) / 10000.0).round(4)
  end

  def brand_colors
    %w(e98091 f7eb73 efa75d 93caf0 70c296 833f92)
  end
end
