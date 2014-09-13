class PostsController < ApplicationController

  def index
    @posts = Post.all

    render json: @posts.as_json(Post.json_params)
  end

  def search
    @posts = Post.within(params.permit(:latitude, :longitude, :miles))

    render json: @posts.as_json(Post.json_params)
  end

  def create
    @photo = Photo.new(params.require(:post).require(:photo).permit(:image))
    @post = Post.new(params.require(:post).permit(:email))

    if @photo.metadata.gps
      @post.latitude = @photo.metadata.gps.latitude
      @post.longitude = @photo.metadata.gps.longitude
      @post.taken_at = @photo.metadata.date_time
    end
    @post.photo = @photo

    @post.save
    redirect_to root_path
  end
end
