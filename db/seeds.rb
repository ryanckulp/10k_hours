default_email = 'admin@10khours.to'
default_password = 'password'

user = User.find_by(email: default_email)
User.create!(email: default_email, password: default_password) if user.nil?
