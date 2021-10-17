# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(user_name:  "管理者",
  email: "admin@example.jp",
  password:  "11111111",
  password_confirmation: "11111111",
  admin: true)

  User.create!(user_name:  "king",
    email: "king@gmail.com",
    password:  "22222222",
    password_confirmation: "22222222",
    admin: true)

8.times do |n|
  user_name = Faker::Games::Pokemon.name
  email = Faker::Internet.email(domain: 'example')
  password = "password"
  User.create!(user_name: user_name,
               email: email,
               password: password, 

               )
end

User.all.each do |user|
  user.tasks.create!(
    task_name: 'aaa',
    content: 'texttext',
    limit: "002025-12-20",
    status: '完了',
    priority: '低'
  )
end

User.all.each do |user|
  user.tasks.create!(
    task_name: 'bbb',
    content: 'texttext',
    limit: "002025-12-23",
    status: '未着手',
    priority: '低'
  )
end
    10.times do |i|
      Label.create!(name: "sample#{i + 1}")
    end