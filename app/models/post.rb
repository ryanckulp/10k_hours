class Post < ApplicationRecord
  include Sluggable
  belongs_to :user

  has_rich_text :content
  validates_presence_of :title, :content
  scope :recent, -> { order(created_at: :desc).limit(10) }

  class << self
    def hours_spent
      all.sum(:hours)
    end

    def dollars_spent
      all.sum(:dollars)
    end

    def dollars_per_hour
      (dollars_spent.to_f / hours_spent.to_f).round(2)
    rescue => e
      'n/a' # may be dividing by zero
    end
  end
end
