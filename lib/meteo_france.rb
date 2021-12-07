# frozen_string_literal: true

require 'httparty'

# MeteoFrance
class MeteoFrance
  include HTTParty
  METEO_FRANCE_URL = 'https://meteofrance.com'
  base_uri 'https://rpcache-aa.meteofrance.com/internet2018client/2.0/nowcast'

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
    @options = {
      headers: {
        'Authorization' => "Bearer #{token}"
      }
    }
  end

  def rain
    response = self.class.get('/rain', @options.merge(query: { lat: @latitude, lon: @longitude }))

    @data = JSON.parse(response.body, symbolize_names: true)

    pp @data

    data_valid? ? rain_output : error_message
  end

  private

  def token
    return @token if defined? @token

    permutation = 13
    response    = HTTParty.get(METEO_FRANCE_URL)
    cookie      = response.headers['set-cookie'].match(/mfsession=([^;]+);/)[1]

    @token = cookie.gsub(/[a-zA-Z]/) do |letter|
      offset = letter <= 'Z' ? 'A'.ord : 'a'.ord
      (offset + (letter.ord + permutation - offset) % 26).chr
    end
  end

  def forecast
    @forecast ||= @data.dig(:properties, :forecast).map do |period|
      period[:time] = Time.parse(period[:time])
      period
    end
  end

  def data_valid?
    @data[:update_time] && @data.dig(:properties, :forecast)
  end

  def rain_output
    {
      update_time: Time.parse(@data[:update_time]),
      coordinates: {
        latitude: @latitude,
        longitude: @longitude
      },
      location: @data.dig(:properties, :name),
      forecast: forecast
    }
  end

  def error_message
    {
      error: true,
      message: "No data for #{@latitude}, #{@longitude}"
    }
  end
end
