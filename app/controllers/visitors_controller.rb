class VisitorsController < ApplicationController
  def index
    @collection = Collection.new
    @post = Post.new
  end
end
