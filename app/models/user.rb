class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cars, dependent: :destroy
  has_many :givings, through: :cars, foreign_key: :giver_car_id
  has_many :takings, through: :cars, foreign_key: :taker_car_id
  # has_many :received_bookings, through: :cars, foreign_key: :taker_car_id, source: :car
end
