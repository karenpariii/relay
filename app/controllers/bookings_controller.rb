class BookingsController < ApplicationController

  def index
    @current_lat = nil
    @current_lng = nil
    if params[:query].present?
      @parkings = Parking.near(params[:query], 1)
                         .joins(:bookings)
                         .where(bookings: { taker_car: nil })
                         .distinct
                        #  .where("bookings.available_at BETWEEN ? AND ?", params[:time] - 10.minutes, params[:time] + 10.minutes)
    else
      @parkings = Parking.all
    end

    @markers = @parkings.geocoded.map do |parking|
      {
        lat: parking.latitude,
        lng: parking.longitude,
        parkingId: parking.id
      }
    end

    if params[:lat].present?
      @current_lat = params[:lat].to_f
      @current_lng = params[:lng].to_f
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "bookings/list", locals: { parkings: @parkings }, formats: [:html] }
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @parking = @booking.parking
    @parking.geocode
    @markers = [{
      lat: @parking.latitude,
      lng: @parking.longitude
    }]
  end

  def new
    @booking = Booking.new
    @parking = current_user.cars.last&.takings&.order(available_at: :desc)&.first&.parking
  end

  def create
    @parking = current_user.cars.last.takings.last.parking
    user_entry_datetime = Time.zone.parse(review_params_booking[:available_at])
    @booking = Booking.new({ available_at: user_entry_datetime })
    @booking.giver_car = current_user.cars.last
    @booking.parking = @parking
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(taker_car: current_user.cars.last)
    BookingChannel.broadcast_to(
      @booking,
      render_to_string(partial: "show_giver", locals: {booking: @booking})
    )
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
