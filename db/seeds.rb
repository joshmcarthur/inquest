# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
  :email => 'tester@example.com',
  :username => 'tester',
  :password => 'password',
  :password_confirmation => 'password'
)

10.times do |num|
  Question.create(
    :user => user,
    :title => "Question #{num}",
    :content => "Content for question #{num}"
  )
end