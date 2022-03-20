# frozen_string_literal: true

require_relative 'lib/meteo_france'
require 'sinatra'
require 'sinatra/json'

RAIN_INTENSITIES = ["  ", "░░", "▒▒", "▓▓", "██"]

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

  minutes = response[:forecast].map do |cell|
    cell[:time].localtime.strftime("%M")
  end

  status 422 if response[:error]

  <<~TXT
    ☀#{RAIN_INTENSITIES.join}☂#{' ' * (26 - 17)}#{Time.now.localtime.strftime("%H:%M")}
    #{'─' * (26)}
    #{minutes.join(" ")}
    #{cells.join(" ")}
  TXT
end
