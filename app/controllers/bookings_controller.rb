class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    authorize @booking
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.post = @post
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def update
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.update(booking_params)
    redirect_to dashboard_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
