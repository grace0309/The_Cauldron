class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :edit, :update]
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.category_id = params[:category]
    @post.save

    redirect_to post_path(@post)
  end

  def edit
  end

  def update
    @post.update(post_params)
    @post = Post.all
  end

  def destroy
    @post.destroy
    @posts = Post.all
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :photo)
  end
end
