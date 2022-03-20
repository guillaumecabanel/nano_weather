# frozen_string_literal: true

require_relative 'lib/meteo_france'
require 'sinatra'
require 'sinatra/json'

RAIN_INTENSITIES = ["  ", "..", "xx", "XX", "##"]

get('/') do
  erb :index
end

get('/:latitude/:longitude/rain') do
  response = MeteoFrance.new(params[:latitude], params[:longitude]).rain

  status 422 if response[:error]
  json response
end

get('/:latitude/:longitude/rain_text') do
  response = MeteoFrance.new(params[:latitude], params[:longitude]).rain

  cells = response[:forecast].map do |cell|
    RAIN_INTENSITIES[cell[:rain_intensity].to_i]
  end
  cells.pop

  minutes = response[:forecast].map do |cell|
    cell[:time].localtime.strftime("%M")
  end
  minutes.pop

  status 422 if response[:error]

  <<~TXT
    *#{RAIN_INTENSITIES.join}J#{' ' * (23 - 17)}#{Time.now.localtime.strftime("%H:%M")}
    #{minutes.join(" ")}
    #{cells.join(" ")}
  TXT
end
