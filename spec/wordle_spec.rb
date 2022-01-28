ENV['TEST'] = 'true'
require 'rspec'
load(File.expand_path('../wordle', File.dirname(__FILE__)))

RSpec.describe Wordle do
  let(:dict) do
    %w{
      alert
      robot
      train
      cause
      sonic
      trust
    }
  end

  let(:wordle) { Wordle.new(dict) }

  it "includes all words before guess" do
    dict.each do |word|
      expect(wordle.possible_words).to include(word)
    end
  end

  it "handles no matches in result" do
    wordle.apply_guess('alert', 'xxxxx')

    expect(wordle.possible_words).to eq(['sonic'])
  end

  it "handles partial matches" do
    wordle.apply_guess('qqqqt', 'xxxx~')
    expect(wordle.possible_words).to eq(['train'])
  end

  it "handles exact matches" do
    wordle.apply_guess('qqqqt', 'xxxxo')
    expect(wordle.possible_words).to eq(['alert', 'robot', 'trust'])
  end

  it "handles multi letter guesses with one exact match" do
    wordle.apply_guess('sqssq', 'xxxox')
    expect(wordle.possible_words).to eq(['cause', 'trust'])
  end

  it "handles multi letter guesses with one partial match" do
    wordle.apply_guess('tqtqq', '~xxxx')
    expect(wordle.possible_words).to eq(['alert', 'robot'])
  end

  it "handles multi letter guesses with multiple partial matches" do
    wordle.apply_guess('qtqtq', 'x~x~x')
    expect(wordle.possible_words).to eq(['trust'])
  end

  it "handles multi letter guesses with multiple exact matches" do
    wordle.apply_guess('tqqqt', 'oxxxo')
    expect(wordle.possible_words).to eq(['trust'])
  end

  it "handles multi letter guesses with partial then exact match" do
    wordle.apply_guess('qtqqt', 'x~xxo')
    expect(wordle.possible_words).to eq(['trust'])
  end

  it "handles multi letter guesses with exact then partial match" do
    wordle.apply_guess('tqqtq', 'oxx~x')
    expect(wordle.possible_words).to eq(['trust'])
  end
end
