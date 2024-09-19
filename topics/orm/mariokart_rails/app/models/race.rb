class Race < ApplicationRecord
  belongs_to :track
  has_many :players
  has_many :laps

  validates :finished_at, comparison: { greater_than: :started_at }
end
