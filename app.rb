require "sinatra"
require "sinatra/reloader"
require "json"
require "dotenv/load"
require "http"



get("/") do

  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @exchange_rate_list_url = "https://api.exchangerate.host/list?access_key=" + @exchange_rate_key
  @raw_response = HTTP.get(@exchange_rate_list_url)
  @parsed_response = JSON.parse(@raw_response)
  @currencies = @parsed_response.fetch("currencies").keys

  erb(:home)
end

get("/:first_currency") do

  @first_curr = params.fetch("first_currency").to_s

  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @exchange_rate_list_url = "https://api.exchangerate.host/list?access_key=" + @exchange_rate_key
  @raw_response = HTTP.get(@exchange_rate_list_url)
  @parsed_response = JSON.parse(@raw_response)
  @currencies = @parsed_response.fetch("currencies").keys

  erb(:first_currency)
end

get("/:first_currency/:second_currency") do

  @first_curr = params.fetch("first_currency").to_s
  @second_curr = params.fetch("second_currency").to_s

  @exchange_rate_key = ENV.fetch("EXCHANGE_RATE_KEY")
  @exchange_rate_value_code = "https://api.exchangerate.host/convert?from=" + @first_curr + "&to=" + @second_curr + "&amount=1&access_key=" + @exchange_rate_key
  @raw_response = HTTP.get(@exchange_rate_value_code)
  @parsed_response = JSON.parse(@raw_response)
  @rate = @parsed_response.fetch("result")
  
  erb(:second_currency)
end
