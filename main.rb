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
  MOST_RARE_PROBABILITY = 1.5 # 季節ガチャ最レア一点狙いの確率に準拠する
  WON  = 'won'
  LOST = 'lost'

  def tweet_entities
    gacha ? load_csv_words(WON) : load_csv_words(LOST)
    @csv_data.map { |csv| csv.to_a.flatten }
  end

  def line
    temporary_entity = tweet_entities.sample
    temporary_entity[rand(temporary_entity.size)]
  end

  private

  def gacha(weight = MOST_RARE_PROBABILITY)
    rand <= weight / 100.0
  end

  def load_csv_words(result)
    Dir.chdir("./csv/#{result}")
    @csv_data = Dir.entries('.').select { |f| /csv/ =~ f }.map { |f| CSV.read(f) }
    Dir.chdir("../../")
  end
end
