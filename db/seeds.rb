# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "faker"

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
Comment.destroy_all
Like.destroy_all

users = []
10.times do
  user = {first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: Faker::Number.between(from: 14, to: 100).to_i, password: "defaultpassword"}
  users.push(user)
end

anonymous_user = {first_name: "anonymous", last_name: "anonymous", description: Faker::Lorem.paragraph, email: Faker::Internet.email, age: Faker::Number.between(from: 14, to: 100).to_i, password: "defaultpassword" }
users.push(anonymous_user)

cities = []
users.length.times do
  city = {name: Faker::Address.city, zip_code: format('%02d', rand(1..95)).to_s + Faker::Number.decimal_part(digits: 3).to_s }
  cities.push(city)
end

users.each_with_index do |user, index|
 user_model = User.new(user)
 user_model.city = City.create(cities[index])
  user_model.save
  puts "#{index + 1} users generated."
  puts "#{index + 1} cities generated."
end
gossips = []
20.times do |i|
  gossip = Gossip.new({title: Faker::Lorem.characters(number: 10), content: Faker::Lorem.paragraphs.join(' '), user: User.all.sample})
  gossip.save
  gossips.push(gossip)
  puts "#{i} gossips generated."
end
tags = []
10.times do |i|
  tag = Tag.new({title: "#" + Faker::Lorem.word})
  tag.save
  tags.push(tag)
  puts "#{i} tags generated."
end

gossips.each_with_index do |gossip, index|
  r = rand(1..3)
  gossip.tags.push(Tag.all.sample)
  if r >= 2
    gossip.tags.push(Tag.all.sample)
  end
  puts "Tag added to gossip #{index}"
end

pms = []
receivers = []
senders = []

10.times do |i|
   random_receivers = [User.all.sample, User.all.sample, User.all.sample]
   random_sender = User.all.sample
   pm = PrivateMessage.new({content: Faker::Lorem.paragraphs.join(' ')})
   pm.sender = random_sender
   pm.recipients = random_receivers
   pm.save

   puts "Private message #{i} added"
end

20.times do |i|
  comment = Comment.create!(content: Faker::Lorem.paragraphs.join(' '), author: User.all.sample, gossip: Gossip.all.sample)
  puts "Comment #{i} added"
end

20.times do |i|
  like = Like.create!(user: User.all.sample, writable: Gossip.all.sample)
end
20.times do |i|
  like = Like.create!(user: User.all.sample, writable: Comment.all.sample)
end