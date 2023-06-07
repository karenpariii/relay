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
  end

  def create
    @parking = current_user.cars.last.givings.last.parking
    @booking = Booking.new(review_params_booking)
    @booking.giver_car = current_user.cars.last
    @booking.parking = @parking
    if @booking.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

private
  def review_params_booking
    params.require(:booking).permit(:available_at)
  end
end
