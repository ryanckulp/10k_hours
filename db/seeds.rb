# create User
user = User.first
User.create!(email: 'admin@10khours.to', password: 'password') if user.nil?

# stub Project
project = Project.first

if project.nil?
  Project.create!(
      name: 'Kulp Estates',
      tagline: 'Tech entrepreneur learning to farm, raise livestock, and build a compound for experiential networking retreats.',
      description: "<a class=\"underline\" href=\"https://github.com/ryanckulp/10k_hours\" target=\"_blank\">10k Hours</a> is a live changelog of improvements to Kulp Estates, a 50 acre ranch outside Atlanta, GA.",
      external_url: 'https://twitter.com/ryanckulp',
  )
end
