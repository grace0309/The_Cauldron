class BookingsController < ApplicationController
  before_action :find_booking, only: [ :show, :destroy, :edit, :update]
  before_action :new_booking, only: [ :new, :create]

  def new
  end

  def show
  end

  def create
    range = (params[:booking][:start_date]).split("to")
    @booking.start_date = range[0]
    @booking.end_date = range[1]
    @booking.user_id = current_user.id
    if @booking.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    redirect_to dashboard_path
  end

  def destroy
    @booking.destroy
    redirect_to dashboard_path
  end

  private

  def new_booking
    @post = Post.find(params[:post_id])
    @booking = Booking.new(post: @post)
    authorize @booking
  end

  def find_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
