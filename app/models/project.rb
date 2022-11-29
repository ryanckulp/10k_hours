class Project < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :banner
  has_one_attached :open_graph

  scope :current, -> { self.first }
end
