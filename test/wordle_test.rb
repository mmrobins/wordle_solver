ENV['TEST'] = 'true'
require 'minitest/autorun'
load(File.expand_path('../wordle', File.dirname(__FILE__)))

class MagicBallTest < Minitest::Test
  def setup
    @wordle = Wordle.new
  end

  def test_no_match
    elim_words = [
      'alert',
      'robot',
      'train',
    ]
    elim_words.each do |word|
      assert_includes(@wordle.possible_words, word)
    end

    @wordle.apply_guess('alert', 'xxxxx')

    elim_words.each do |word|
      refute_includes(@wordle.possible_words, word)
    end
  end

  def test_partial_match
    elim_words = [
      'alert',
      'robot'
    ]
    elim_words.each do |word|
      assert_includes(@wordle.possible_words, word)
    end

    @wordle.apply_guess('alert', 'xxxx~')

    elim_words.each do |word|
      refute_includes(@wordle.possible_words, word)
    end
  end
end
