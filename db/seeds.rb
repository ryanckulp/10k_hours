default_email = 'admin@10khours.to'
default_password = 'password'

user = User.find_by(email: default_email)

if user.nil?
  User.create!(
    email: default_email,
    password: default_password,
    bio: '10k Hours is a live changelog of improvements to Kulp Estates, a 50 acre ranch outside Atlanta, GA.',
    project_name: 'Kulp Estates',
    project_description: 'Tech entrepreneur learning to farm, raise livestock, and build a compound for experiential networking retreats.'
  )
end
