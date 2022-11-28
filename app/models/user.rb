class User < ApplicationRecord
  include Signupable

  has_many :posts

  scope :default_user, -> { self.first }
end
