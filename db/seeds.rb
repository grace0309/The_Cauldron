# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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
    User.create(name: name, email: email, password: '123456')
  end
end
puts 'Finished!'

puts 'Creating posts...'

puts 'Creating spells...'
response = RestClient.get 'https://www.potterapi.com/v1/spells?key=$2a$10$64FSHysMBSjgcbf/TFJN9OFIbsWkBfgye2rU8nEpM7LJB4GPgZmg6'
result = JSON.parse(response)[0...10]
result.each do |spell|
  title = spell['spell']
  desc = spell['effect'].capitalize
  price = rand(10...50)
  user = User.all.sample
  category = Category.find_by category: 'Spells'
  Post.create(title: title, description: desc, price: price, user: user, category: category)
end

puts 'Creating creatures...'
response = RestClient.get 'https://www.potterapi.com/v1/characters/?key=$2a$10$64FSHysMBSjgcbf/TFJN9OFIbsWkBfgye2rU8nEpM7LJB4GPgZmg6'
result = JSON.parse(response)
result.each do |character|
  if character['species'] != 'human' && character['species'] != 'part-human'
    name = character['name']
    desc = character['species'].capitalize
    user = User.all.sample
    category = Category.find_by category: 'Creatures'
    price = rand(30...100)
    Post.create(title: name, description: desc, price: price, user: user, category: category)
  end
end

# puts 'Creating wand...'
# response = RestClient.get 'https://www.potterapi.com/v1/characters/?key=$2a$10$64FSHysMBSjgcbf/TFJN9OFIbsWkBfgye2rU8nEpM7LJB4GPgZmg6'
# result = JSON.parse(response)
# result.each do |character|
#   if character['species'] != 'human' && character['species'] != 'part-human'
#     name = character['name']
#     desc = character['species'].capitalize
#     user = User.all.sample
#     category = Category.find_by category: 'Creatures'
#     price = rand(60...200)
#     Post.create(title: name, description: desc, price: price, user: user, category: category)
#   end
# end

puts 'Finished!'
