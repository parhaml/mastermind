#! /usr/bin/env ruby

class Game
  def initialize
    @range = nil
    @code_options = []
    @master = Master.new
    @guesser = Guesser.new
    @code_length = 4
  end

  def range
    @range
  end

  def guesser
    @guesser
  end

  def master
    @master
  end

  def code_length
    @code_length
  end

  def code_options
    @code_options
  end

  def play_game
    #game control here
  end

  def quick_start
    set_random_game_code
  end

  def make_guess
    guess = guesser.make_guess
    master.score_guess(guess)
  end

  def set_code_options
    !range.nil? && range > 1 ? @code_options = (1..range).map(&:to_i) : set_range
  end

  def set_random_game_code
    if code_options.empty?
      set_code_options
      set_random_game_code
    else
      code_length.times { master.code << @code_options[rand(range)] }
    end
  end

  def set_custom_game_code
    # give option to let master set their own code
  end

  def set_range
    puts "How many numbers do you want to guess from (Greater than 1)?"
    @range = gets.chomp.to_i

    if @range > 1
      set_code_options
    else
      puts "Please enter a number greater than 1"
      set_range
    end
  end
end

class Master < Game
  def initialize
    @code = []
  end

  def code
    @code
  end

  def score_guess(guess)
    require 'pry'; binding.pry
    puts "The Master has received #{guess}"
    return "You Won" if guess == code
    common = guess & code
    display_common_numbers(common)
    response = []
    guess.each_with_index {|num, idx| num == code[idx] ? response << num : response << "X" }
    puts "Here are your correct guesses: #{response}"
  end

  def display_common_numbers(common)
    common.each{|num| p "There are #{code.count(num)} #{num}'s in the code"}
  end
end

class Guesser < Game
  def initialize
    @remaining_guesses = 10
  end

  def remaining_guesses
    @remaining_guesses
  end

  def reduce_remaining_guesses
    @remaining_guesses -= 1
  end

  def make_guess
    puts 'Guesser, Make a guess'
    guess = gets.chomp.split('').map(&:to_i)
    puts "You guessed #{guess}"
    reduce_remaining_guesses
    puts "You have #{remaining_guesses} guesses left"
    guess
  end
end
