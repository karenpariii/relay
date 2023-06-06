class Car < ApplicationRecord
  belongs_to :user
  has_many :givings, class_name: "Booking", foreign_key: :giver_car_id, dependent: :destroy
  has_many :takings, class_name: "Booking", foreign_key: :taker_car_id, dependent: :destroy
end
