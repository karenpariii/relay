class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.datetime :available_at
      t.references :car, null: false, foreign_key: true
      t.references :new_car, null: false, foreign_key: { to_table: "cars" }
      t.references :parking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
 