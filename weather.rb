#!/usr/bin/env ruby

require "open_weather"
require "geo_stalker"
require "fc2"

require "digest/md5"
require "tmpdir"

class Weather
  include Fc2
  ICONS = {
    "Thunderstorm" => "⛈",
    "Drizzle" => "🌫",
    "Rain" => "☔️",
    "Snow" => "⛄️",
    "Atmosphere" => "🌫",
    "Clear" => "☀️",
    "Clouds" => "☁️",
    "Extreme" => "🌪",
  }

  use_cache def now_icon
    loc = GeoStalker::Locator.new(ENV["GOOGLE_API_KEY"]).location["location"]
    info = OpenWeather::Current.geocode(
      loc["lat"],
      loc["lng"],
      APPID: ENV["OPEN_WEATHER_KEY"])
    ICONS[info["weather"].first["main"]]
  end
end
puts Weather.new.now_icon
