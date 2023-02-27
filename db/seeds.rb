require 'open-uri'
require 'json'

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = "http://tmdb.lewagon.com/movie/top_rated"
base_poster_url = "https://image.tmdb.org/t/p/original"
results = JSON.parse(URI.open("#{url}").read)["results"]

results.each do |result|
  puts "Creating #{result['title']}"
  title = result["title"]
  overview = result["overview"]
  rating = result["vote_average"]
  img_path = result["backdrop_path"]
  img_url = "#{base_poster_url}#{img_path}"
  Movie.create(title:title, overview:overview, rating:rating, poster_url:img_url)
end
puts "Movies created"
