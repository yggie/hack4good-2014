class Collection < ActiveRecord::Base

  def json_params
    {
      except: [:id, :created_at, :updated_at]
    }
  end
end
