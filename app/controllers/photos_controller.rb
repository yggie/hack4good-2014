class PhotosController < ApplicationController
  def create
    @photo = Photo.create(params.require(:photo).permit!)

    redirect_to root_path
  end
end
