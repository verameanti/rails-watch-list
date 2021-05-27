# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Cleaning database..."
Movie.destroy_all

puts "Creating some movies..."

response = RestClient.get "http://tmdb.lewagon.com/movie/top_rated"
repos = JSON.parse(response)
base_url = "https://image.tmdb.org/t/p/original"
movie_results = repos["results"]
movie_results.each do |movie_hash|
  title = movie_hash["title"]
  overview = movie_hash["overview"]
  poster_url = base_url + movie_hash["poster_path"]
  rating = movie_hash["vote_average"]
  Movie.create!(title: title, overview: overview, poster_url: poster_url, rating: rating)
  puts "Created movies"
end
  puts "finished creating movies!"
