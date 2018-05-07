# coding: utf-8
require 'csv'
require 'twitter'
require 'dotenv'
Dotenv.load
class TwitterClient
  TEN_STONES_RARE_PROBABILITY = 7.5 # 定額ガチャ最レアの確率に準拠し、それの3匹分に相当する（ネイ進化後等を除く）（2018年5月現在）
  WON  = 'won'
  LOST = 'lost'

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def words_to_tweet
    temporary_entity = tweet_entities.sample
    temporary_entity[rand(temporary_entity.size)]
  end

  def tweet
    @client.update(words_to_tweet)
  end

  private

  def gacha(weight = TEN_STONES_RARE_PROBABILITY)
    rand <= weight/100.0
  end

  def load_csv_words(result)
    Dir.chdir("./csv/#{result}")
    @csv_data = Dir.entries('.').select { |f| /csv/ =~ f }.map { |f| CSV.read(f) }
    Dir.chdir("../../")
  end

  def tweet_entities
    gacha ? load_csv_words(WON) : load_csv_words(LOST)
    @csv_data.map { |csv| csv.to_a.flatten }
  end
end
