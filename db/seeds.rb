# create User
user = User.first
User.create!(email: DEFAULT_VALUES['ADMIN_EMAIL'], password: DEFAULT_VALUES['ADMIN_PASSWORD']) if user.nil?

# stub Project
project = Project.current

if project.nil?
  Project.create!(
    name: DEFAULT_VALUES['PROJECT_NAME'],
    tagline: DEFAULT_VALUES['TAGLINE'],
    description: DEFAULT_VALUES['DESCRIPTION'],
    external_url: DEFAULT_VALUES['EXTERNAL_URL']
  )
end
