puts "Cleaning database ..."

User.destroy_all
Car.destroy_all
Booking.destroy_all
Parking.destroy_all

require "open-uri"

romaintaker = User.create!(first_name: "Romain", last_name: "Caillard", email: "romain@gmail.com", password: "azerty")
karengiver = User.create!(first_name: "Karen", last_name: "Kouassi", email: "karen@gmail.com", password: "azerty")
magalietaker = User.create!(first_name: "Magalie", last_name: "Mares", email: "magalie@gmail.com", password: "azerty")
aligiver = User.create!(first_name: "Ali", last_name: "Ouzidhouh", email: "ali@gmail.com", password: "azerty")
damsogiver = User.create!(first_name: "Damso", last_name: "Rappe", email: "damso@gmail.com", password: "azerty")

orelgiver = User.create!(first_name: "Orel", last_name: "Sanne", email: "orel@gmail.com", password: "azerty")
valdgiver = User.create!(first_name: "Vald", last_name: "Efontnay", email: "vald@gmail.com", password: "azerty")
sylviegiver = User.create!(first_name: "Sylvie", last_name: "Dupont", email: "sylvie@gmail.com", password: "azerty")


car_romaintaker = Car.create!(car_model: "Renault Twizy", plate: "AA-567-EB", car_color: "Mauve", car_type: "citadine", user: romaintaker)
car_karengiver = Car.create!(car_model: "Renault Clio", plate: "AA-123-BB", car_color: "Rouge", car_type: "citadine", user: karengiver)
car_magalietaker = Car.create!(car_model: "Renault Zoé", plate: "AB-456-CD", car_color: "Bleu", car_type: "citadine", user: magalietaker)
car_aligiver = Car.create!(car_model: "Renault Scénic", plate: "AZ-678-ER", car_color: "Jaune", car_type: "berline", user: aligiver)
car_damsogiver = Car.create!(car_model: "Hummer limousine", plate: "AQ-567-KL", car_color: "Paillette", car_type: "van", user: damsogiver)

car_orelgiver = Car.create!(car_model: "Peugeot 205", plate: "AR-908-KL", car_color: "Bleue", car_type: "citadine", user: orelgiver)
car_valdgiver = Car.create!(car_model: "Ford Fiesta", plate: "ER-897-4L", car_color: "Rose", car_type: "citadine", user: valdgiver)
car_sylvigiver = Car.create!(car_model: "Fiat Panda", plate: "ER-897-4L", car_color: "A Fleurs", car_type: "citadine", user: sylviegiver)


parking_1 = Parking.create!(address: "68 avenue parmentier, 75011 PARIS", latitude: "48.86348471131329", longitude: "2.3769894173515214")
parking_2 = Parking.create!(address: "5 rue moret, 75011 PARIS", latitude: "48.86686306488304", longitude: "2.3802539543881234")
parking_3 = Parking.create!(address: "63, boulevard Voltaire, 75011 PARIS", latitude: "48.8619468876249", longitude: "2.3732971684091635")
parking_4 = Parking.create!(address: "30 Rue René Boulanger, 75010 Paris", latitude: "48.86869353316412", longitude: "2.3619321708694296")
parking_5 = Parking.create!(address: "110 Rue Amelot, 75011 Paris", latitude: "48.86349719499158", longitude: "2.3671810438195084")
parking_6 = Parking.create!(address: "49 Rue du Chemin Vert, 75011 Paris", latitude: "48.85964004829994", longitude: "2.375311098558855")

parking_7 = Parking.create!(address: "13 rue saint hubert, 75011 PARIS", latitude: "48.86420259820049", longitude: "2.380070412328287")
parking_8 = Parking.create!(address: "127 rue saint maur, 75011 PARIS", latitude: "48.86730979370463", longitude: "2.3755347681490186")


booking_1 = Booking.create!(available_at: 15.minutes.from_now, parking: parking_1, giver_car: car_karengiver)
booking_2 = Booking.create!(available_at: 20.minutes.from_now, parking: parking_2, giver_car: car_aligiver)
booking_3 = Booking.create!(available_at: 25.minutes.from_now, parking: parking_3, giver_car: car_damsogiver)
booking_4 = Booking.create!(available_at: 30.minutes.from_now, parking: parking_4, giver_car: car_karengiver)
booking_5 = Booking.create!(available_at: 35.minutes.from_now, parking: parking_5, giver_car: car_aligiver)
booking_6 = Booking.create!(available_at: 40.minutes.from_now, parking: parking_6, giver_car: car_damsogiver)

booking_7 = Booking.create!(available_at: 45.minutes.from_now, parking: parking_7, giver_car: car_orelgiver)
booking_8 = Booking.create!(available_at: 50.minutes.from_now, parking: parking_8, giver_car: car_valdgiver)

puts "seeds upload all"
