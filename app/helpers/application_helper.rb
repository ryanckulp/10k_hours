module ApplicationHelper
  def project_name
    User.default_user.project_name
  end

  def project_description
    User.default_user.project_description
  end

  def project_bio
    User.default_user.bio
  end
end
