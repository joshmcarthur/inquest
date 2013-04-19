# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count.zero?
  30.times do
    email = Faker::Internet.email
    User.create(
      :email => email,
      :username => email.split('@').first,
      :password => 'password',
      :password_confirmation => 'password'
    )
  end
end

questions = []

if Question.count.zero?
  200.times do
    owner = User.all.sample
    owner.questions.create(
     :title => Faker::Lorem.words(10).join(" ") + "?",
      :content => Faker::Lorem.paragraphs(4).join(" "),
    )
  end
end

if Answer.count.zero?
  300.times do
    question = Question.all.sample
    user = User.all.sample
    question.answers.create(
      :content => Faker::Lorem.paragraphs(2).join(" "),
      :user => user
    )
  end
end

if Tag.count.zero?
  YAML.load_file(Rails.root.join 'db', 'seeds', 'default_tags.yml').each do |default_tag|
    Tag.where(name: default_tag).first_or_create
  end
end
