class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.post = @post
    @review.user_id = current_user.id
    if @review.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to post_path(@review.post)
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to post_path(@post)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
