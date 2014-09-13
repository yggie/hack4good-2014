class PhotosController < ApplicationController
  def new
    @photo = Photo.new
  end

  def create
    file = params[:photo][:image]
    @photo = Photo.new(params.require(:photo).permit!)

    case file.content_type
    when 'image/jpeg'
      @exif = EXIFR::JPEG.new(file.tempfile.path)

    else
      raise 'Unsupported extension'
    end

    render json: @exif.gps
  end
end
