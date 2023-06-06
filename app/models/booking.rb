class Booking < ApplicationRecord
  belongs_to :giver_car, class_name: "Car"
  belongs_to :taker_car, class_name: "Car"
  belongs_to :parking
end
