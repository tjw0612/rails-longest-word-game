require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @guess = params[:guess]
    @word = params[:letters].split('').select { |v| v =~ /[A-Z]/ }
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@guess}")
    json = JSON.parse(response.read)

    if @guess.chars.all? { |letter| @guess.count(letter) > @word.count(letter.upcase) }
      @message = "Sorry but #{@guess.upcase} can't be built out of #{@word.join(",")}"
    elsif json['found'] == false
      @message = "Sorry but #{@guess.upcase} does not seem to be a valid word..."
    else
      @message = "Congratulations! #{@guess.upcase} is a valid English word."
    end
  end
end
