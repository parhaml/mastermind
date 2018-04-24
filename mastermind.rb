#! /usr/bin/env ruby

class Master
  def initialize
    @code = []
  end

  def score_guess
  end

  def code
    @code
  end
end

class Guesser
  def initialize
    @tries = 10
  end

  def make_guess
    puts 'Guesser, Make a guess'
    guess = gets.chomp.split('').map(&:to_i)
    @tries -= 1
    puts "You guessed #{guess}"
  end
end

class Game
  def initialize
    @range = nil
    @code_options = []
    @master = Master.new
    @guesser = Guesser.new
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

  def code_options
    @code_options
  end

  def set_code_options
    !range.nil? && range > 1 ? @code_options = (1..range).map(&:to_i) : set_range
  end

  def set_random_game_code
    4.times { master.code << @code_options[rand(range)] }
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
