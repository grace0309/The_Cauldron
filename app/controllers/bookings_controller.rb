class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @booking = Booking.new(booking_params)
    @booking.post = @post
    @booking.user_id = current_user.id
    ##########################
    if @booking.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
