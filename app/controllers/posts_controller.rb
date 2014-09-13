class PostsController < ApplicationController

  def search
    @posts = Post.within(params.permit(:latitude, :longitude, :miles))

    render json: @posts.as_json(include: :photo)
  end

  def create
    @photo = Photo.new(params.require(:post).require(:photo).permit(:image))
    @post = Post.new(params.require(:post).permit(:email))

    if @photo.metadata.gps
      @post.latitude = @photo.metadata.gps.latitude
      @post.longitude = @photo.metadata.gps.longitude
    end
    @post.photo = @photo

    @post.save
    redirect_to root_path
  end
end
