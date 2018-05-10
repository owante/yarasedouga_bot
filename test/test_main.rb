require 'main'

class String
  def screen_width
    hankaku_len = self.each_char.count {|x| x.ascii_only? }
    (hankaku_len + (self.size - hankaku_len) * 2) / 2
  end
end

class LineTest < Test::Unit::TestCase
  def test_initialize
    assert Line.new(Gacha.gacha)
    assert_raise { Line.new }
  end

  def test_tweet_entities
    assert Line.new(Gacha::Result::LOST).tweet_entities
    assert Line.new(Gacha::Result::WON).tweet_entities

    line = Line.new(Gacha::Result::LOST)
    assert line.tweet_entities(Gacha::Result::LOST)
    assert line.tweet_entities(Gacha::Result::WON)
    assert_raise { line.tweet_entities('make') }
    assert_raise { line.tweet_entities('') }

    Line.new(Gacha::Result::LOST).tweet_entities.each do |words|
      words.each { |tweet| puts tweet if tweet.to_s.screen_width > 140 }
      assert words.all? { |tweet| tweet.to_s.screen_width <= 140 }
    end

    Line.new(Gacha::Result::WON).tweet_entities.each do |words|
      words.each { |tweet| puts tweet if tweet.to_s.screen_width > 140 }
      assert words.all? { |tweet| tweet.to_s.screen_width <= 140 }
    end
  end
end
