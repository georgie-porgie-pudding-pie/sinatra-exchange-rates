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
  erb(:flexible)
end
