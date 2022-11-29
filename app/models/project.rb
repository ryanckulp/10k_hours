class Project < ApplicationRecord
  scope :current, -> { self.first }
end
