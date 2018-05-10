require 'main'

class String
  def screen_width
    hankaku_len = self.each_char.count {|x| x.ascii_only? }
    (hankaku_len + (self.size - hankaku_len) * 2) / 2
  end
end

class LineTest < Test::Unit::TestCase
  def test_tweet_entities
    assert Line.new.words_to_tweet
  end

  def test_tweet_entities
    Line.new.tweet_entities.each do |words|
      words.each { |tweet| puts tweet if tweet.to_s.screen_width > 140 }
      assert words.all? { |tweet| tweet.to_s.screen_width <= 140 }
    end
  end
end
