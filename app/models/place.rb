class Place < ApplicationRecord
  has_many :stages

  validates :name, :address, presence: true
  validates :latitude, numericality: true, allow_nil: true
  validates :longitude, numericality: true, allow_nil: true
  validates :name, uniqueness: true

end
