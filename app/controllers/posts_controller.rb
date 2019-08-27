class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_post, only: [:show, :destroy, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    @post.category_id = params[:post][:category_id]
    @post.user_id = current_user.id
    @post.save
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
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
