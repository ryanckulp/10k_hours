class Post < ApplicationRecord
  include Sluggable
  belongs_to :user

  VISIBILITY_OPTIONS = %w(public draft)

  has_rich_text :content
  validates_presence_of :title, :content, :dollars, :hours, :visibility
  validates_uniqueness_of :slug

  scope :published, -> { where(visibility: 'public') }
  scope :draft, -> { where(visibility: 'draft') }
  scope :newest_to_oldest, -> { order(published_at: :desc) }
  scope :featured, -> { published.where(featured: true).newest_to_oldest.limit(10) }

  def truncated_preview
    meta_description || content.to_plain_text.truncate(280)
  end

  def featured_image_url
    first_image_url
  rescue => e # probably no 'image' type attachments, revert to og
    Project.current.open_graph.url
  end

  # content.embeds.find() grabs oldest image by created_at;
  # if user adds a new image at top later, it won't become featured, thus the filename lookup
  def first_image_url
    filename = content.body.to_s.split('filename=')[1].split(' filesize')[0].gsub('"','')
    content.embeds.find { |embed| embed.image? && filename == embed.blob.filename.to_s }.url
  rescue => e
    content.embeds.find { |embed| embed.image? }.url
  end

  class << self
    def hours_spent
      published.sum(:hours)
    end

    def dollars_spent
      published.sum(:dollars)
    end

    def dollars_per_hour
      (dollars_spent.to_f / hours_spent.to_f).round(2)
    rescue => e
      'n/a' # may be dividing by zero
    end
  end
end
