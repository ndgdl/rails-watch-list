require 'json'
require 'open-uri'

puts "Cleaning DB..."
List.destroy_all if Rails.env.development?
Movie.destroy_all if Rails.env.development?

puts "DB cleaned"

puts "Seeding movies..."

api_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=10905904ad5de9b8c29f5aec179c5077"

top_movies = JSON.parse(URI.open(api_url).read)["results"]

top_movies.each do |top_movie|
  Movie.create!(
    title: top_movie["title"],
    overview: top_movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{top_movie["poster_path"]}",
    rating: top_movie["vote_average"])
end

puts "Seeding lists..."

hindi_movies = List.new(name: "Hindi movies")
hindi_movies.save!
hindi_movies.photo.attach(io: File.open('app/assets/images/bollywood.png'), filename: 'bollywood.png', content_type: 'img/png')

crime_movies = List.new(name: "Crime movies")
crime_movies.save!
crime_movies.photo.attach(io: File.open('app/assets/images/crime.png'), filename: 'bollywood.png', content_type: 'img/png')

japanese_movies = List.new(name: "Japanese movies")
japanese_movies.save!
japanese_movies.photo.attach(io: File.open('app/assets/images/japan.png'), filename: 'bollywood.png', content_type: 'img/png')

puts "Seeding bookmarks..."

movies = Movie.all.to_a

rand(1..5).times do
  Bookmark.create!(
    comment: "#{Faker::Emotion.adjective.capitalize}, #{Faker::Emotion.adjective} and #{Faker::Emotion.adjective}!",
    movie_id: movies.shuffle!.pop.id,
    list_id: hindi_movies.id
  )
end

rand(1..5).times do
  Bookmark.create!(
    comment: "#{Faker::Emotion.adjective.capitalize}, #{Faker::Emotion.adjective} and #{Faker::Emotion.adjective}!",
    movie_id: movies.shuffle!.pop.id,
    list_id: crime_movies.id
  )
end

rand(1..5).times do
  Bookmark.create!(
    comment: "#{Faker::Emotion.adjective.capitalize}, #{Faker::Emotion.adjective} and #{Faker::Emotion.adjective}!",
    movie_id: movies.shuffle!.pop.id,
    list_id: japanese_movies.id
  )
end

puts "Seeding completed:"
puts "#{Movie.count} movies created"
