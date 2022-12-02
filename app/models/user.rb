class User < ApplicationRecord
  include Signupable

  has_many :posts, dependent: :destroy
end
