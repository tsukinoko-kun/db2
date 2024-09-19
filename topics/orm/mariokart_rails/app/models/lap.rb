class Lap < ApplicationRecord
  belongs_to :player
  belongs_to :race
  
  # in ms
  validates :duration, numericality: { only_integer: true, greater_than: 1 }

  delegate :track, :to => :race, :allow_nil => true
end
