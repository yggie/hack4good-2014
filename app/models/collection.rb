class Collection < ActiveRecord::Base

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :latitude, presence: true, numericality: true
  validates :longitude, presence: true, numericality: true

  def json_params
    {
      except: [:id, :created_at, :updated_at]
    }
  end
end
