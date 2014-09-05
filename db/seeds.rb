# create dummy organisations
puts "Creating organisations"
20.times do
  Organisation.create(name: Faker::Company.name, description: Faker::Company.catch_phrase)
end
