# create User
user = User.first
User.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD']) if user.nil?

# stub Project
project = Project.first

if project.nil?
  Project.create!(
      name: ENV['PROJECT_NAME'],
      tagline: ENV['TAGLINE'],
      description: ENV['DESCRIPTION'],
      external_url: ENV['EXTERNAL_URL']
  )
end
