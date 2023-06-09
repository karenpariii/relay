class BookingsController < ApplicationController

  def index
    if params[:query].present?
      @parkings = Parking.near(params[:query], 1)
                         .joins(:bookings)
                         .where(bookings: { taker_car: nil })
                        #  .where("bookings.available_at BETWEEN ? AND ?", params[:time] - 10.minutes, params[:time] + 10.minutes)
    else
      @parkings = Parking.none
    end

    @markers = @parkings.geocoded.map do |parking|
      {
        lat: parking.latitude,
        lng: parking.longitude
      }
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @parking = current_user.cars.last.givings.last.parking
  end

  def create
    @parking = current_user.cars.last.givings.last.parking
    user_entry_datetime = DateTime.strptime(review_params_booking[:available_at], '%Y-%m-%dT%k:%M')
    @booking = Booking.new({ available_at: user_entry_datetime })
    @booking.giver_car = current_user.cars.last
    @booking.parking = @parking
    if @booking.save
      redirect_to bookings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(taker_car: current_user.cars.last)
    redirect_to booking_path(@booking)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, status: :see_other
  end

  private

  def review_params_booking
    params.require(:booking).permit(:available_at)
  end
end
