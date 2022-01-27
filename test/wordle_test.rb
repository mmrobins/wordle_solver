ENV['TEST'] = 'true'
require 'minitest/autorun'
load(File.expand_path('../wordle', File.dirname(__FILE__)))

class MagicBallTest < Minitest::Test
  def setup
    @dict = %w{
      alert
      robot
      train
      cause
    }
    @wordle = Wordle.new(@dict)
  end

  def test_before_guess
    @dict.each do |word|
      assert_includes(@wordle.possible_words, word)
    end
  end

  def test_no_match
    @wordle.apply_guess('alert', 'xxxxx')

    assert @wordle.possible_words == []
  end

  def test_partial_match
    @wordle.apply_guess('qqqqt', 'xxxx~')
    assert @wordle.possible_words == ['train']
  end

  def test_exact_match
    @wordle.apply_guess('qqqqt', 'xxxxo')
    assert @wordle.possible_words == ['alert', 'robot']
  end

  def test_double_letter_guess_one_exact_match
    @wordle.apply_guess('qaqsq', 'xoxox')
    assert_includes(@wordle.possible_words, 'cause')
  end

  def test_double_letter_guess_one_partial_match
    @wordle.apply_guess('tqtqt', '~xxxx')
    assert_includes(@wordle.possible_words, 'alert')
    assert_includes(@wordle.possible_words, 'robot')
  end
end
