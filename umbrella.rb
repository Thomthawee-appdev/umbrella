p "Where are you located?"

user_location = gets.chomp

#p user_location

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"


#p gmaps_url

require "open-uri"
raw_response = URI.open(gmaps_url).read

#p raw_response

require "json"
parsed_response = JSON.parse(raw_response)

#p parsed_response.keys

results_array = parsed_response.fetch("results")

first_result = results_array.at(0)

#p first_result.keys

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

#p latitude
#p longitude

weather_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"

weather_response = URI.open(weather_url).read

weather_parsed_response = JSON.parse(weather_response)

#p weather_parsed_response.keys

current = weather_parsed_response.fetch("currently").fetch("temperature")
#p current

hourly = weather_parsed_response.fetch("hourly").fetch("summary")
#prediction
#p hourly

prediction = Array.new
if hourly == "Clear"
  prediction.append("You probably won't need the umbrella")
else
  prediction.append("You need the umbrella")
end
#Assemble the correct Pirate Weather URL using 

p "Checking the weather at #{user_location}..."
p "Your coordinates are #{latitude} , #{longitude}."
p "It is currently #{current} F"
p "Next hour: #{hourly} "
p prediction[0]
