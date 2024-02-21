require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    # @letters += Array.new(5) {(('A'..'A').to_a).sample}
    @letters = Array.new(10) { (('A'..'Z').to_a ).sample }
    @letters.shuffle!
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
    @word = params[:word]
    @letters = params[:letters]

    if user["found"]
       if contain(params[:word],params[:letters])
        @result = 2
      else
        @result = 1 # grid err
      end
    else
      @result = 0
    end
    # raise
  end

  private
  def contain(attempt, grid)
    split_user = attempt.upcase.chars
    bool = true
    array = grid.split(' ')
    split_user.each do |element|
      if array.include?(element)
        index = array.find_index(element)
        array.delete_at(index) if index
      else
        bool = false
      end
    end
    return bool
  end

end
