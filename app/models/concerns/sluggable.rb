module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :generate_slug
    before_update :regenerate_slug
  end

  def generate_slug
    slug_to_save = title.parameterize.downcase

    if Post.where(slug: slug_to_save).count > 1
      slug_to_save += "-#{SecureRandom.hex(3)}" # avoid user-facing error with slug suffix
    end

    self.slug = slug_to_save
  end
  alias_method :regenerate_slug, :generate_slug
end
