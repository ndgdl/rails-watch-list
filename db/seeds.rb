require 'json'
require 'open-uri'

puts "Cleaning DB..."
Movie.destroy_all
puts "DB cleaned"

puts "Seeding..."

api_key = '10905904ad5de9b8c29f5aec179c5077'
api_url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}"

top_movies = JSON.parse(URI.open(api_url).read)["results"]

top_movies.each do |top_movie|
  Movie.create!(
    title: top_movie["title"],
    overview: top_movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500/#{top_movie["poster_path"]}",
    rating: top_movie["vote_average"])
end


puts "Seeding completed:"
puts "#{Movie.count} movies created"
