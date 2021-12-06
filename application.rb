# frozen_string_literal: true

require_relative 'lib/meteo_france'
require 'sinatra'

get('/') do
  erb :index
end

get('/rain/:latitude/:longitude') do
  response = MeteoFrance.new.rain(params[:latitude], params[:longitude])

  if response[:error]
    status 422
    body response[:message].to_json
  else
    response.to_json
  end
end
