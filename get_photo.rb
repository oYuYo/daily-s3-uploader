#! /usr/bin/ruby

require 'net/http'
require 'open-uri'
require 'json'
require './change_widepics.rb'

def save_photo(rnd, i, result)
  #reference of size -> https://www.flickr.com/services/api/misc.urls.html
  server_id = result[:photos][:photo][rnd][:server]
  id = result[:photos][:photo][rnd][:id]
  secret = result[:photos][:photo][rnd][:secret]
  size_suff = 'b'

  url = URI.parse("https://live.staticflickr.com/#{server_id}/#{id}_#{secret}_#{size_suff}.jpg")
  file = "./pics#{i}.jpg"

  URI.open(file, 'wb') do |pass|
    URI.open(url) do |recieve|
      pass.write(recieve.read)
    end
  end
  
  img = WidePics.new(file)
  img.change_widepics(file) if img.is_vertical_image
end


api_key = ENV["API_KEY"]
user_id = ENV["USER_ID"]
uri = URI.parse("https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=#{api_key}&user_id=#{user_id}&format=json&nojsoncallback=1")

begin
  res = Net::HTTP.get_response(uri)
  case res
  when Net::HTTPSuccess
    result = JSON.parse(res.body, {symbolize_names: true})
    max_size = result[:photos][:photo].size

    2.times do |i|
      random = Random.new
      rnd = random.rand(0...max_size)
      save_photo(rnd, i+1, result)
      result[:photos][:photo].delete_at(rnd)
    end
  else
    p response.header
  end

rescue JSON::ParserError
  puts "JSON::ParserError"
rescue => e
  puts e.message
end
