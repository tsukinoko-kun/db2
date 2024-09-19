class Track < ApplicationRecord
  has_many :races
	has_many :laps, :through => :races

  validates :name, presence: true
  validates :length, numericality: { only_integer: true, greater_than: 0 }
end
