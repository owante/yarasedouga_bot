require 'main'

module TestProbability
  PROBABILITY = Gacha::MOST_RARE_PROBABILITY
end

class GachaFeatureTest < Test::Unit::TestCase
  def test_gacha_result_by_set
    puts '100セット10回で成功する回数を検証します：'
    10.times do |turn|
      count = 0
      100.times do
        result = Gacha.gacha(TestProbability::PROBABILITY)
        count += 1 if result == Gacha::Result::WON
      end
      puts "ガチャ100回（#{turn + 1}セット目）のヤラセ成功回数：#{count}回"
    end
    puts '-------------------------------------'
  end

  def test_gacha_result_by_day
    day = 8
    total_days = 30
    puts "1日#{day}回を1ヶ月引いて成功する回数を検証します："
    total_count = 0
    total_days.times do |turn|
      count = 0
      day.times do
        result = Gacha.gacha(TestProbability::PROBABILITY)
        if result == Gacha::Result::WON
          count += 1
          total_count += 1
        end
      end
      puts "#{turn + 1}日目のヤラセ成功回数：#{count}回"
    end
    puts '-------------------------------------'
    puts "この月は#{total_count}回成功しました。"
    puts '-------------------------------------'
  end
end
