require 'main'

class TwitterClientTest < Test::Unit::TestCase
  def test_initialize
    assert TwitterClient.new
  end
  def test_tweet_entities
    assert TwitterClient.new.words_to_tweet
  end
end
