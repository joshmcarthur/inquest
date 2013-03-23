# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


user = User.create(
  :email => 'admin@example.com', 
  :password => 'example user', 
  :password_confirmation => 'example user'
)

10.times do |num|
  Question.create(
    :user => user,
    :title => "Question #{num}",
    :content => "Content for question #{num}"
  )
end