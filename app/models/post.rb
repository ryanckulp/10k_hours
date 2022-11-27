class Post < ApplicationRecord
  has_rich_text :content

  scope :recent, -> { order(created_at: :desc).first(10) }
end
