class Post < ApplicationRecord
  include Sluggable
  belongs_to :user

  has_rich_text :content
  validates_presence_of :title, :content
  validates_uniqueness_of :slug

  scope :newest_to_oldest, -> { order(published_at: :desc) }
  scope :featured, -> { where(featured: true).newest_to_oldest }

  def truncated_preview
    meta_description || content.to_plain_text.truncate(140)
  end

  def featured_image
    return if content.embeds.empty?
    content.embeds.find { |embed| embed.image? }
  end

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
