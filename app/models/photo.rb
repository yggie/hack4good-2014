class Photo < ActiveRecord::Base
  attr_reader :metadata, :exif

  dragonfly_accessor :image

  def thumbnail
    image.thumb('150x150').url
  end

  def exif
    return @exif if @exif

    case image.mime_type
    when 'image/jpeg'
      @exif = EXIFR::JPEG.new(image.path)

    end

    @exif
  end

  def metadata
    @metadata || OpenStruct.new.tap do |data|
      data.gps = exif.gps
    end
  end
end
