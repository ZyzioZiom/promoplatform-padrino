class Level < ActiveRecord::Base
  validates :name, presence: true
  validates :points, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :image, presence: true, format: { with: URI.regexp }
  validates_presence_of :points
end
