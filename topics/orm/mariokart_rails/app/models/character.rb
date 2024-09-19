class Character < ApplicationRecord
  has_many :players

  validates :name, presence: true
  validates :speed, numericality: { only_integer: true, greater_than: 1, less_than: 6 }
  validates :traction, numericality: { only_integer: true, greater_than: 1, less_than: 6 }
end
