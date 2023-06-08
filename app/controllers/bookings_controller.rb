class BookingsController < ApplicationController

  def index
    @parkings = Parking.joins(:bookings).where(bookings: { taker_car: nil })
    @markers = @parkings.geocoded.map do |parking|
      {
        lat: parking.latitude,
        lng: parking.longitude
      }
    end
  end

  def show

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
    redirect_to dashboard_path
  end

  def delete
  end

  private

  def review_params_booking
    params.require(:booking).permit(:available_at)
  end
end
