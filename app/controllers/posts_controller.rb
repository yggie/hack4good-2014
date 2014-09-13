class PostsController < ApplicationController
  def create
    @post = Post.create(params.require(:post).permit!)

    redirect_to root_path
  end
end
