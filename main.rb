# coding: utf-8
require 'csv'
require 'twitter'

class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def tweet(line)
    @client.update(line)
  end
end

class Line
  def initialize(result)
    fail ArgumentError if !result || result.empty?
    @result = result
  end

  def tweet_entities(choice = nil)
    if choice
      fail ArgumentError if choice.empty?
      load_csv_words(choice)
    else
      load_csv_words(@result)
    end
    @csv_data.map { |csv| csv.to_a.flatten }
  end

  def line
    temporary_entity = tweet_entities.sample
    temporary_entity[rand(temporary_entity.size)]
  end

  private

  def load_csv_words(result)
    Dir.chdir("./csv/#{result}")
    @csv_data = Dir.entries('.').select { |f| /csv/ =~ f }.map { |f| CSV.read(f) }
    Dir.chdir("../../")
  end
end

class Gacha
  MOST_RARE_PROBABILITY = 0.5 # ☆7フェス限一点狙いの確率に準拠する
  module Result
    WON  = 'won'
    LOST = 'lost'
  end

  def self.gacha(weight = MOST_RARE_PROBABILITY)
    rand <= weight / 100.0 ? Result::WON : Result::LOST
  end
end
