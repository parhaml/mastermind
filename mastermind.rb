#! /usr/bin/env ruby
require './game'
require './guesser'
require './master'

def show_game_menu
  system "clear"
  puts "Welcome to Mastermind! \nChoose from the options below:\n\n"
  puts "1. Human Guesser, Comuter Master"
  puts "2. Human Master, Computer Guesser"
  puts "3. Exit\n\n"

  choice = gets.chomp
  case choice
    when "1"
      Game.new("AI", "Human").play_game
    when "2"
      Game.new("Human","AI").play_game
    else
      puts "Bye!"
      @running = false
  end
  return
end

show_game_menu
