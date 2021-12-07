# frozen_string_literal: true

require_relative 'lib/meteo_france'
require 'sinatra'

get('/') do
  erb :index
end

get('/:latitude/:longitude/rain') do
  response = MeteoFrance.new(params[:latitude], params[:longitude]).rain

  if response[:error]
    status 422
    body response[:message]
  else
    response.to_json
  end
end
