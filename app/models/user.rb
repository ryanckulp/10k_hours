class User < ApplicationRecord
  include Signupable

  has_many :posts
end
