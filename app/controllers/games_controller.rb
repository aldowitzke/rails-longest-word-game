require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word]

    @message =
      if !included?(@word, @letters)
        'Not in the grid'
      elsif valid_word?(@word)
        'This word is a english word!'
      else
        'This is not an English word'
      end
  end

  private

  def valid_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url).read
    JSON.parse(response)['found']
  end

  def included?(word, letters)
    word.upcase.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
