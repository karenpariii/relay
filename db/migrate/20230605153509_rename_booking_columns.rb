class RenameBookingColumns < ActiveRecord::Migration[7.0]
  def change
    rename_column(:bookings, :car_id, :giver_car_id)
    rename_column(:bookings, :new_car_id, :taker_car_id)
  end
end
