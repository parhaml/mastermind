#! /usr/bin/env ruby

class Master
  @code = []
end

class Guesser
  @tries = 10

  def make_guess
    puts 'Make a Guess'
    guess = gets.chomp.split('').map(&:to_i)
    puts "You guessed #{guess}"
  end
end

class Game
  def initialize
    @range = nil
    @code_options = []
    @code = []
    @master = Master.new
    @guesser = Guesser.new
  end

  def range
    @range
  end

  def code_options
    @code_options
  end

  def set_code_options
    @code_options = (1..range).map(&:to_i)
  end

  def set_game_code
    4.times { @code << @code_options[rand(range)] }
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
