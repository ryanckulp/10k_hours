module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :generate_slug
    before_update :regenerate_slug
  end

  def generate_slug
    self.slug = title.parameterize.downcase
  end
  alias_method :regenerate_slug, :generate_slug
end
