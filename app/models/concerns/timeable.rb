module Timeable
  extend ActiveSupport::Concern

  included do
    before_create :set_precise_published_at
  end

  def set_precise_published_at
    return if recurring?
    pub_to_be_saved = self.published_at

    if (pub_to_be_saved.min && pub_to_be_saved.hour && pub_to_be_saved.sec).zero?
      self.published_at = DateTime.now
    end
  end
end
