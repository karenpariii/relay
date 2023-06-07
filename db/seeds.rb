puts "Cleaning database ..."

User.destroy_all
Car.destroy_all
Booking.destroy_all
Parking.destroy_all

require "open-uri"

romaintaker = User.create!(first_name: "romain", last_name: "Caillard", email: "romain@gmail.com", password: "azerty")
karengiver = User.create!(first_name: "karen", last_name: "Kouassi", email: "karen@gmail.com", password: "azerty")
magalietaker = User.create!(first_name: "magalie", last_name: "Mares", email: "magalie@gmail.com", password: "azerty")
aligiver = User.create!(first_name: "ali", last_name: "Ouzidhouh", email: "ali@gmail.com", password: "azerty")
damsogiver = User.create!(first_name: "damso", last_name: "Rappe", email: "damso@gmail.com", password: "azerty")


car_romaintaker = Car.create!(car_model: "Renault Twizy", plate: "AA-567-EB", car_color: "Mauve", car_type: "citadine", user: romaintaker)
car_karengiver = Car.create!(car_model: "Renault Clio", plate: "AA-123-BB", car_color: "Rouge", car_type: "citadine", user: karengiver)
car_magalietaker = Car.create!(car_model: "Renault Zoé", plate: "AB-456-CD", car_color: "Bleu", car_type: "citadine", user: magalietaker)
car_aligiver = Car.create!(car_model: "Renault Scénic", plate: "AZ-678-ER", car_color: "Jaune", car_type: "berline", user: aligiver)
car_damsogiver = Car.create!(car_model: "Hummer limousine", plate: "AQ-567-KL", car_color: "Paillette", car_type: "van", user: damsogiver)


parking_1 = Parking.create!(address: "68 avenue parmentier, 75011 PARIS", latitude: "48.86348471131329", longitude: "2.3769894173515214")
parking_2 = Parking.create!(address: "5 rue moret, 75011 PARIS", latitude: "48.86686306488304", longitude: "2.3802539543881234")
parking_3 = Parking.create!(address: "63, boulevard Voltaire, 75011 PARIS", latitude: "48.8619468876249", longitude: "2.3732971684091635")


booking_1 = Booking.create!(available_at: "20230606130100", parking: parking_1, giver_car: car_karengiver )
booking_2 = Booking.create!(available_at: "20230606132300", parking: parking_2, giver_car: car_aligiver )
booking_3 = Booking.create!(available_at: "20230606133300", parking: parking_3, giver_car: car_damsogiver, taker_car: car_romaintaker )

puts "seeds upload all"
