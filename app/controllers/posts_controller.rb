class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :edit, :update]

  def index
    @posts = Post.all
    # @posts = Post.all
    @mapped_posts = Post.geocoded
    markers(@mapped_posts)
    coordinates = [params[:location][:lat], params[:location][:long]]
    @near_posts = Post.near(coordinates, 20)
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
    @posts = Post.all
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update(post_params)
    @posts = Post.all
    redirect_to dashboard_path
  end

  def destroy
    authorize @post
    @post.destroy
    @posts = Post.all
    redirect_to dashboard_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :price, :photo)
  end

  def markers(mapped_posts)
    @markers = mapped_posts.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { post: post })
      }
    end
  end

  def near_post
    result = request.location
    coordinates = result.first.coordinates
    @near_posts = Post.near(coordinates, 1)
  end
end
