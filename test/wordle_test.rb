ENV['TEST'] = 'true'
require 'minitest/autorun'
load(File.expand_path('../wordle', File.dirname(__FILE__)))

class WordleTest < Minitest::Test
  def setup
    @dict = %w{
      alert
      robot
      train
      cause
      sonic
      trust
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

    assert @wordle.possible_words == ['sonic']
  end

  def test_partial_match
    @wordle.apply_guess('qqqqt', 'xxxx~')
    assert @wordle.possible_words == ['train']
  end

  def test_exact_match
    @wordle.apply_guess('qqqqt', 'xxxxo')
    assert @wordle.possible_words == ['alert', 'robot', 'trust']
  end

  def test_multi_letter_guess_one_exact_match
    @wordle.apply_guess('sqssq', 'xxxox')
    assert_includes(@wordle.possible_words, 'cause')
  end

  def test_multi_letter_guess_one_partial_match
    @wordle.apply_guess('tqtqq', '~xxxx')
    assert_includes(@wordle.possible_words, 'alert')
    assert_includes(@wordle.possible_words, 'robot')
  end

  def test_multi_letter_guess_multiple_partial_match
    @wordle.apply_guess('qtqtq', 'x~x~x')
    assert_includes(@wordle.possible_words, 'trust')
  end

  def test_multi_letter_guess_multiple_exact_match
    @wordle.apply_guess('tqqqt', 'oxxxo')
    assert_includes(@wordle.possible_words, 'trust')
  end

  def test_multi_letter_guess_partial_match_then_exact_match
    @wordle.apply_guess('qtqqt', 'x~xxo')
    assert_includes(@wordle.possible_words, 'trust')
  end

  def test_multi_letter_guess_exact_match_then_partial_match
    @wordle.apply_guess('tqqtq', 'oxx~x')
    assert_includes(@wordle.possible_words, 'trust')
  end
end
