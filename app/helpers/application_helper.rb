module ApplicationHelper
  def project_start_date
    Post.first.created_at.strftime('%B %d, %Y')
  rescue
    Date.today.strftime('%B %d, %Y')
  end

  def project_avatar
    Project.current.avatar.url || 'avatar.png' # default 10k Hours logo
  end

  def project_banner
    Project.current.banner.url
  end

  def project_progress_percentage
    (Post.hours_spent.round(1) / 10000.0).round(4)
  end

  def brand_colors
    %w(e98091 f7eb73 efa75d 93caf0 70c296 833f92)
  end
end
