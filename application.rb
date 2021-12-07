# frozen_string_literal: true

require_relative 'lib/meteo_france'
require 'sinatra'
require 'sinatra/json'

get('/') do
  erb :index
end

get('/:latitude/:longitude/rain') do
  response = MeteoFrance.new(params[:latitude], params[:longitude]).rain

  status 422 if response[:error]
  json response
end
