class Collection < ActiveRecord::Base

  has_many :posts

  def json_params
    {
      except: [:id, :created_at, :updated_at]
    }
  end
end
