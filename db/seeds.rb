# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
15.times do |n|
    Player.create(
      name: "Player #{n + 1}",
      picture: "player#{n + 1}.jpg",
      email: "player#{n + 1}@example.com",
      infractions: 0,
      chips: 1000,
      rating: 0
    )
  end