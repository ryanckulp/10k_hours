module ApplicationHelper
  def project_name
    User.default_user.project_name
  end

  def project_description
    User.default_user.project_description.html_safe
  end

  def project_bio
    User.default_user.bio.html_safe
  end

  def project_progress_percentage
    (Post.hours_spent.round(1) / 10000.0).round(4)
  end
end
