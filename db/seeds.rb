# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup)
Review.destroy_all
Booking.destroy_all
Post.destroy_all
Category.destroy_all
User.destroy_all

puts 'Creating categories...'
Category.create(category: 'Wands')
Category.create(category: 'Potions')
Category.create(category: 'Creatures')
Category.create(category: 'Spells')
puts 'Finished!'

puts 'Creating users...'
response = RestClient.get 'http://hp-api.herokuapp.com/api/characters'
result = JSON.parse(response)[0...5]
result.each do |character|
  if character['species'] == 'human'
    name = character['name']
    email = "#{name.downcase.delete(' ')}@hogwarts.com"
    image_url = "name.downcase.delete(' ').jpg"
    User.create(name: name, email: email, password: '123456', image_url: image_url)
  end
end
puts 'Finished!'

puts 'Creating posts...'
puts 'Creating spells...'
spells = Category.find_by category: 'Spells'
response = RestClient.get 'https://www.potterapi.com/v1/spells?key=$2a$10$64FSHysMBSjgcbf/TFJN9OFIbsWkBfgye2rU8nEpM7LJB4GPgZmg6'
result = JSON.parse(response)[0...5]
result.each do |spell|
  title = spell['spell']
  desc = spell['effect'].capitalize
  price = rand(10...50)
  user = User.all.sample
  address = Faker::Address.street_address
  photo = "https://source.unsplash.com/600x400/?spell,#{title}"
  Post.create(title: title, description: desc, price: price, user: user, category: spells, photo: photo, address: address)
end

puts 'Creating creatures...'
creatures = Category.find_by category: 'Creatures'
response = RestClient.get 'https://www.potterapi.com/v1/characters/?key=$2a$10$64FSHysMBSjgcbf/TFJN9OFIbsWkBfgye2rU8nEpM7LJB4GPgZmg6'
result = JSON.parse(response)[0...100]
result.each do |character|
  if character['species'] != 'human' && character['species'] != 'part-human'
    name = character['name']
    desc = character['species'].capitalize
    user = User.all.sample
    price = rand(30...100)
    address = Faker::Address.street_address
    photo = "https://source.unsplash.com/600x400/?creature,#{name}"
    Post.create(title: name, description: desc, price: price, user: user, category: creatures, photo: photo, address: address)
  end
end

puts 'Creating potions...'
potions = Category.find_by category: 'Potions'
5.times do
  user = User.all.sample
  post = Post.new(
    title: Faker::Coffee.blend_name,
    description: Faker::Coffee.notes,
    price: rand(10...50),
    user: user,
    category: potions,
    address: Faker::Address.street_address
  )
  post.photo = "https://source.unsplash.com/600x400/?potion,#{post.title}"
  post.save!
end

puts 'Creating wands...'
wands = Category.find_by category: 'Wands'
4.times do
  user = User.all.sample
  post = Post.new(
    title: Faker::Games::Pokemon.move,
    description: Faker::Games::Pokemon.location,
    price: rand(10...50),
    user: user,
    category: wands,
    address: Faker::Address.street_address
  )
  post.photo = "https://source.unsplash.com/600x400/?wand,#{post.title}"
  post.save
end
puts 'Finished!'

puts 'Creating bookings...'
20.times do
  user = User.all.sample
  post = Post.all.sample
  review = Booking.create(
    user: user,
    post: post,
    start_date: Date.today + rand(5..10),
    end_date: Date.today + rand(10..20),
    )
end

puts 'Creating reviews...'
20.times do
  user = User.all.sample
  booking = Booking.all.sample
  review = Review.create(
    user: user,
    booking: booking,
    content: Faker::Quote.famous_last_words
    )
end

puts 'Finished!'

