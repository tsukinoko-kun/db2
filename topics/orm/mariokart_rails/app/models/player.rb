class Player < ApplicationRecord
  belongs_to :character
  belongs_to :race, optional: true
  has_many :laps
  
  validates :name, presence: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
