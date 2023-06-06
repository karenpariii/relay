class Booking < ApplicationRecord
  belongs_to :giver_car, class_name: "Car"
  belongs_to :taker_car, class_name: "Car", optional: true
  belongs_to :parking

  validates :available_at, presence: true
end
