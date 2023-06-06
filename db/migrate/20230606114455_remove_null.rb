class RemoveNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bookings, :taker_car_id, true
  end
end
