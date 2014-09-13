class CollectionsController < ApplicationController

  def index
    @collections = Collection.all

    render json: @collections.as_json(Collection.json_params)
  end

  def create
    @collection = Collection.new(params.require(:collection).permit(:radius, :latitude, :longitude, :criteria, :title))

    if @collection.save
    else
      render json: @collection.as_json(Collection.json_params)
    end
  end

end
