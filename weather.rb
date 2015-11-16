#!/usr/bin/env ruby

require "open_weather"
require "geo_stalker"

def icon(group)
  case group
  when "Thunderstorm"
    "⛈"
  when "Drizzle"
    "🌫"
  when "Rain"
    "☔️"
  when "Snow"
    "⛄️"
  when "Atmosphere"
    "🌫"
  when "Clear"
    "☀️"
  when "Clouds"
    "☁️"
  when "Extreme"
    "🌪"
  end
end

CACHE = "/tmp/weather.rb.cache"

if File.exist?(CACHE) && (Time.now - File::Stat.new(CACHE).mtime) <= 300
  print File.read(CACHE)
  exit
end

loc = GeoStalker::Locator.new(ENV["GOOGLE_API_KEY"]).location["location"]
info = OpenWeather::Current.geocode(loc["lat"], loc["lng"], APPID:ENV["OPEN_WEATHER_KEY"])
icon = icon(info["weather"].first["main"])
open(CACHE, 'w'){|io| io.print icon }
puts icon
