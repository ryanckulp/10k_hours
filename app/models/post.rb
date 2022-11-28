class Post < ApplicationRecord
  include Sluggable
  belongs_to :user

  has_rich_text :content, service: (Rails.env.production? ? :amazon_prod : :amazon_dev)
  validates_presence_of :title, :content
  validates_uniqueness_of :slug

  scope :newest_to_oldest, -> { order(published_at: :desc) }
  scope :featured, -> { where(featured: true).newest_to_oldest }

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
