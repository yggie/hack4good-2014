class Post < ActiveRecord::Base

  has_one :photo

  validates :email, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  scope :within, ->(options) do
    latitude = Float(options.fetch(:latitude))
    longitude = Float(options.fetch(:longitude))
    dist_in_degrees = Float(options.fetch(:miles)) / 69.0
    where('((latitude - ?)^2.0 + (longitude - ?)^2.0) < ?',
      latitude, longitude, dist_in_degrees**2)
  end
end
