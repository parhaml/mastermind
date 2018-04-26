#! /usr/bin/env ruby

class Game
  def initialize
    @code_options = []
    @master = Master.new
    @guesser = Guesser.new
    @code_length = 4
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
    while guesser.remaining_guesses > 0
      if guesser.won
        puts "You Won! It took you #{10 - guesser.remaining_guesses} guesses."
        puts "Press any key to continute"
        gets.chomp
        g = Game.new
        g.show_game_menu
      else
        make_guess
      end
    end

    puts "You lost the game, the code was #{master.code}"
    puts "Press any key to continute"
    gets.chomp
    g = Game.new
    g.show_game_menu
  end

  def show_game_menu
    system "clear"
    puts "Welcome to Mastermind! \nChoose from the options below:\n\n"
    puts "1. Quick Start\n"
    puts "2. Exit\n"
    choice = gets.chomp
    case choice
    when "1"
      quick_start
    else
      return "Bye!"
    end
  end

  def quick_start
    set_random_game_code
    play_game
  end

  def make_guess

    guess = guesser.make_guess
    result = master.score_guess(guess)
    guesser.won = true if result == 1
  end

  def set_code_options
    @code_options = (1..8).map(&:to_i)
  end

  def set_random_game_code
    if code_options.empty?
      set_code_options
      set_random_game_code
    else
      code_length.times { master.code << @code_options[rand(8)] }
    end
  end

  def set_custom_game_code
    # give option to let master set their own code
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
    system "clear"
    puts "The Master has received #{guess}"
    return 1 if guess == code
    display_common_numbers(guess)
    response = []
    guess.each_with_index {|num, idx| num == code[idx] ? response << num : response << "X" }
    puts "Here are your correct guesses: #{response}"
  end

  def display_common_numbers(guess)
    common = guess & code
    common.each{|num| p "There are #{code.count(num)} #{num}'s in the code"}
  end
end

class Guesser < Game
  def initialize
    @remaining_guesses = 10
    @won = nil
  end

  def remaining_guesses
    @remaining_guesses
  end

  def remaining_guesses=(value)
    @remaining_guesses = value
  end

  def won
    @won
  end

  def won=(value)
    @won = value
  end

  def reduce_remaining_guesses
    @remaining_guesses -= 1
  end

  def make_guess
    puts "Guesser, have #{remaining_guesses} guesses left. Make a guess"
    guess = gets.chomp.split('').map(&:to_i)
    puts "You guessed #{guess}"
    reduce_remaining_guesses
    guess
  end
end

g = Game.new
g.show_game_menu