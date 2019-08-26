class PostsController < ApplicationController
  def index
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
