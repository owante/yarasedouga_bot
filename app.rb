require 'sinatra'
require_relative 'main.rb'

# URL'/'でアクセス
get '/' do
  'under construction'
end

# URL'/random_tweet'でアクセス
get '/random_tweet' do
  TwitterClient.new.tweet
end
