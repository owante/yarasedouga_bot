require 'sinatra'
require_relative 'main.rb'

# URL'/'でアクセス
get '/' do
  'under construction'
end

# URL'/random_tweet'でアクセス
get '/random_tweet' do
  line = Line.new.line
  TwitterClient.new.tweet(line)
end
